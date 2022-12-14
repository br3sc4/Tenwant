//
//  AppointmentRepresentable.swift
//  AccommodationApp
//
//  Created by Massidé Dosso on 12/12/22.
//

import SwiftUI
import EventKitUI

struct AddAppointmentView: UIViewControllerRepresentable {
    typealias UIViewControllerType = EKEventEditViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<AddAppointmentView>) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.eventStore = EKEventStore()
        controller.event = EKEvent(eventStore: controller.eventStore)
        controller.editViewDelegate = context.coordinator
        
        Task {
            await requestCalendarAccess(for: controller.eventStore)
        }
        
        return controller
    }

    func updateUIViewController(_ uiViewController: AddAppointmentView.UIViewControllerType, context: UIViewControllerRepresentableContext<AddAppointmentView>) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator : NSObject, EKEventEditViewDelegate {
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            switch action {
            case .canceled:
                controller.cancelEditing()
                controller.dismiss(animated: true)
            case .saved:
                do {
                    try controller.eventStore
                        .save(controller.event!,
                              span: .thisEvent,
                              commit: true)
                    controller.dismiss(animated: true)
                } catch {
                    print("❌ - \(error)")
                }
            case .deleted:
                print("⚠️ - Deleted")
            @unknown default:
                break
            }
        }
    }
    
    private func requestCalendarAccess(for store: EKEventStore) async {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            break
        case .denied:
            break
        case .notDetermined:
            do {
                try await store.requestAccess(to: .event)
            } catch {
                print("❌ - \(error)")
            }
        case .restricted:
            break
        @unknown default:
            break
        }
    }
}

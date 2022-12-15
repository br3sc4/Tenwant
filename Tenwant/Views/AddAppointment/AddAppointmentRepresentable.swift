//
//  AppointmentRepresentable.swift
//  AccommodationApp
//
//  Created by Massidé Dosso on 12/12/22.
//

import SwiftUI
import EventKitUI

struct AddAppointmentRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = EKEventEditViewController
    
    private var appointmentVM: AppointmentViewModel
    @EnvironmentObject private var accommodationVM: AccommodationDetailViewModel
    
    init(appointmentVM: AppointmentViewModel) {
        self.appointmentVM = appointmentVM
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<AddAppointmentRepresentable>) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.eventStore = appointmentVM.store
        controller.event = EKEvent(eventStore: appointmentVM.store)
        controller.editViewDelegate = context.coordinator
        
        return controller
    }

    func updateUIViewController(_ uiViewController: AddAppointmentRepresentable.UIViewControllerType, context: UIViewControllerRepresentableContext<AddAppointmentRepresentable>) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(accommodationVM: accommodationVM)
    }

    class Coordinator : NSObject, EKEventEditViewDelegate {
        private var accommodationVM: AccommodationDetailViewModel
        
        init(accommodationVM: AccommodationDetailViewModel) {
            self.accommodationVM = accommodationVM
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            switch action {
            case .canceled:
                controller.dismiss(animated: true)
            case .saved:
                do {
                    try controller.eventStore
                        .save(controller.event!,
                              span: .thisEvent,
                              commit: true)
                    accommodationVM.bookAppointment(for: controller.event!.startDate, viewContext: PersistenceController.shared.viewContext)
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
}

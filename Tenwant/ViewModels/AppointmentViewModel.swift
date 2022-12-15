//
//  AppointmentViewModel.swift
//  Tenwant
//
//  Created by Lorenzo Brescanzin on 15/12/22.
//

import EventKit

final class AppointmentViewModel: ObservableObject {
    @Published var calendarAccessGaranted: Bool = true
    
    let store: EKEventStore = EKEventStore()
    
    init() {
        Task {
            await requestCalendarAccess()
        }
    }
    
    private func requestCalendarAccess() async {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            Task { @MainActor in
                calendarAccessGaranted = true
            }
        case .denied:
            Task { @MainActor in
                calendarAccessGaranted = false
            }
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

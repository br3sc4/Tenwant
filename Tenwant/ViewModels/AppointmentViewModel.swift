//
//  AppointmentViewModel.swift
//  Tenwant
//
//  Created by Lorenzo Brescanzin on 15/12/22.
//

import EventKit

final class AppointmentViewModel: ObservableObject {
    @Published var calendarAccessGaranted: Bool = false
    
    let store: EKEventStore = EKEventStore()
    
    init() {
        Task {
            await requestCalendarAccess()
        }
    }
    
    private func requestCalendarAccess() async {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            calendarAccessGaranted = true
        case .denied:
            calendarAccessGaranted = false
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

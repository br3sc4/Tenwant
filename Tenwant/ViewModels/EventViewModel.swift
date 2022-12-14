//
//  EventViewModel.swift
//  Tenwant
//
//  Created by Lorenzo Brescanzin on 14/12/22.
//

import EventKit

final class EventViewModel: ObservableObject {
    let store: EKEventStore = EKEventStore()
    @Published var event: EKEvent?
    
    init() {
        Task {
            await requestCalendarAccess()
        }
    }
    
    private func requestCalendarAccess() async {
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

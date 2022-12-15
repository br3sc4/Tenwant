//
//  AddAppointmentView.swift
//  Tenwant
//
//  Created by Lorenzo Brescanzin on 15/12/22.
//

import SwiftUI
import EventKit

struct AddAppointmentView: View {
    @StateObject private var appointmentVM: AppointmentViewModel = AppointmentViewModel()
    @EnvironmentObject private var accommodationVM: AccommodationDetailViewModel
    
    var body: some View {
        if appointmentVM.calendarAccessGaranted {
            AddAppointmentRepresentable(appointmentVM: appointmentVM)
        } else {
            AddAppointmentSheetView()
        }
    }
}

struct AddAppointmentView_Previews: PreviewProvider {
    @StateObject static private var accommodationVM: AccommodationDetailViewModel = .init(accommodation: .fuorigrotta)
    
    static var previews: some View {
        AddAppointmentView()
            .environmentObject(accommodationVM)
    }
}

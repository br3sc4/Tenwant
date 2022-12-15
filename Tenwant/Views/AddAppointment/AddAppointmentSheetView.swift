//
//  AddAppointmentSheetView.swift
//  Tenwant
//
//  Created by Lorenzo Brescanzin on 15/12/22.
//

import SwiftUI
import CoreData

struct AddAppointmentSheetView: View {
    @State private var date: Date = Date.now
    @EnvironmentObject private var vm: AccommodationDetailViewModel
    @Environment(\.dismiss) private var dismiss: DismissAction
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date",
                           selection: $date,
                           displayedComponents: [.date, .hourAndMinute])
            }
            .navigationTitle("Add Appointment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        vm.bookAppointment(for: date, viewContext: moc)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddAppointmentSheetView_Previews: PreviewProvider {
    @StateObject static private var vm = AccommodationDetailViewModel(accommodation: .init())
    
    static var previews: some View {
        AddAppointmentSheetView()
            .environmentObject(vm)
    }
}

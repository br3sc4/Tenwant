//
//  AddAccomodationView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct AddAccomodationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView{
            Text("hhh")
            
            
                .navigationTitle("Add a new Accomodation")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button(action: {
                            dismiss()
                        }, label:
                                {
                            Text("Cancel")
                        })
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button(action: {}, label:
                                {
                            Text("Save")
                        })
                    }
                }
        }
    }
}

struct AddAccomodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccomodationView()
    }
}

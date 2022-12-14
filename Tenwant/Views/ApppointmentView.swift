//
//  ApppointmentView.swift
//  AccommodationApp
//
//  Created by Massidé Dosso on 12/12/22.
//



import SwiftUI

struct Event: View {
    @State private var isShowingImagePicker = false
    
    @Environment(\.dismiss) var dismiss
    @State private var isPresentingConfirm: Bool = false

    
    var body: some View {
        
        Text("New Appointement")
            .font(.headline)
            .foregroundColor(.black)
                    .padding()
                    .onTapGesture { isShowingImagePicker = true }
                    .sheet(isPresented: $isShowingImagePicker, content: {
                   //     NewEventGenerator( )
                    })
    
    }
}


struct Event_Previews: PreviewProvider {
    static var previews: some View {
        Event()
    }
}

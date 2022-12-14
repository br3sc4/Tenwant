//
//  ActionButtonView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 14/12/22.
//

import SwiftUI

struct ActionButtonView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var role: String
    var symbolName: String
    var textLabel: String
    var action: () -> Void
    
    var body: some View {
        if colorScheme == .light {
            Button(action: action) {
                VStack(spacing: 3) {
                    Image(systemName: symbolName)
                        .foregroundColor(role == "delete" ? .red : .accentColor)
                    
                    Text(textLabel.capitalized)
                        .foregroundColor(role == "delete" ? .red : .accentColor)
                        .font(.system(size: 11))
                        .font(.subheadline)
                }
                .frame(width: role == "isFavourite" ? 65 : 55, height: 50)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(UIColor.systemBackground))
        } else {
            Button(action: action) {
                VStack(spacing: 3) {
                    Image(systemName: symbolName)
                        .foregroundColor(role == "delete" ? .red : .accentColor)
                    
                    Text(textLabel.capitalized)
                        .foregroundColor(role == "delete" ? .red : .accentColor)
                        .font(.system(size: 11))
                        .font(.subheadline)
                        .frame(width: role == "isFavourite" ? 65 : 55)
                }
                .frame(width: 55, height: 50)
            }
            .buttonStyle(BorderedButtonStyle())
        }
    }
}

//struct ActionButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActionButtonView()
//    }
//}

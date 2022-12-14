//
//  AccommodationSheetView.swift
//  Tenwant
//
//  Created by Lorenzo Brescanzin on 14/12/22.
//

import SwiftUI
import CoreLocation

struct AccommodationSheetView: View {
    private let accommodation: Accomodation
    private let userLocation: CLLocation
    
    @FetchRequest(sortDescriptors: [])
    private var pointsOfInterest: FetchedResults<PointOfInterest>
    
    init(accommodation: Accomodation, userLocation: CLLocation) {
        self.accommodation = accommodation
        self.userLocation = userLocation
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    if let image = accommodation.card_cover,
                        let uiImage = UIImage(data: image) {
                        VStack {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(width: 180, height: 150)
                        .clipShape(Rectangle())
                        .shadow(radius: 2)
                        .cornerRadius(14)
                    } else {
                        VStack{
                            Image("ph1")
                                .resizable()
                                .scaledToFill()
                        }
                        .frame(width: 180, height: 150)
                        .clipShape(Rectangle())
                        .shadow(radius: 2)
                        .cornerRadius(14)
                    }
                    
                    VStack {
                        VStack {
                            Text("Type")
                                .font(.headline)
                            Text(accommodation.type?.capitalized ?? "No type provided")
                                .font(.subheadline)
                        }
                        Divider()
                        VStack {
                            Text("Rent price")
                                .font(.headline)
                            Text(accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                                .font(.subheadline)
                        }
                        Divider()
                        VStack {
                            Text("Extra costs")
                                .font(.headline)
                            Text(accommodation.extra_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                                .font(.subheadline)
                        }
                    }
                }
                .padding([.leading, .trailing], 10)
                
                VStack(alignment: .leading) {
                    Text("Distance from:")
                        .font(.headline)
                        .padding([.leading, .top], 15)
                    
                    List {
                        HStack {
                            Text("Current user location -")
                                .font(.subheadline)
                            Text(accommodation.distance(from: userLocation)
                                .formatted(.measurement(width: .abbreviated,
                                                        usage: .road,
                                                        numberFormatStyle: .number.precision(.fractionLength(.zero)))))
                                .font(.subheadline)
                        }
                        
                        ForEach(pointsOfInterest, id: \.id) { point in
                            HStack {
                                if let name = point.name {
                                    Text(name + " -")
                                        .font(.subheadline)
                                    Text(accommodation.distance(from: CLLocation(latitude: point.latitude,
                                                                                 longitude: point.longitude))
                                        .formatted(.measurement(width: .abbreviated,
                                                                usage: .road,
                                                                numberFormatStyle: .number.precision(.fractionLength(.zero)))))
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .padding([.trailing,], 15)
                }
            }
            .frame(maxWidth: .infinity)
            .navigationTitle(accommodation.wrappedTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AccommodationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationSheetView(accommodation: .fuorigrotta, userLocation: .init())
    }
}

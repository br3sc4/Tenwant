////
////  MyCalendarWeeklyView.swift
////  AccommodationApp
////
////  Created by Antonella Giugliano on 08/12/22.
////
//
//import SwiftUI
//import UIKit
//
//
//struct MyCalendarWeeklyView: UIViewControllerRepresentable {
//    
//    @StateObject private var vm: CalendarViewModel
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    init(accommodations: [Accomodation]) {
//        self._vm = StateObject(wrappedValue: CalendarViewModel(accommodation: accommodations))
//    }
//
//    typealias UIViewControllerType = CalendarViewController
//    
//   
//        func makeUIViewController(context: Context) -> CalendarViewController {
//         let calendar = CalendarViewController()
//         calendar.configureCalendarView()
//        
//         
//         return calendar
//     }
//     
//     func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
//         
//     }
// }
//
////struct MyCalendarWeeklyView_Previews: PreviewProvider {
////    static var previews: some View {
////        MyCalendarWeeklyView()
////    }
////}

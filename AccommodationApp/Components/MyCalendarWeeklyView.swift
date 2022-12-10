////
////  MyCalendarWeeklyView.swift
////  AccommodationApp
////
////  Created by Antonella Giugliano on 08/12/22.
////
//
//import SwiftUI
//
//struct MyCalendarWeeklyView: View {
//    @State var now = Date.now
//    //    private var weeklyDays = ["SUN":1, "MON": 2 , "TUE": 3, "WED": 4, "THR":5, "FRI":6, "SAT":7]
//    private var weeklyDays = ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"]
//    var currentWeek = [Date?]()
//    //    private var thisWeek =
//    
//    var body: some View {
//        VStack(){
//            Text(now.formatted(date: .long, time: .omitted))
//                .bold()
//                .font(.system(size: 20))
//            HStack{
//                Button(action:
//                        {},
//                       label: {
//                    Image(systemName: "chevron.left")
//                })
//                .foregroundColor(.accentColor)
//                Spacer()
//                Button(action:
//                        {},
//                       label: {
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(.accentColor)
//                })
//            }.padding(10)
//            HStack{
//                ForEach(0..<weeklyDays.count, id: \.self) { idx in
//                    VStack{
//                        Text(weeklyDays[idx])
//                            .foregroundColor(.black)
//                            .font(.system(size: 14))
//                        
//                        Text(weeklyDays[(Calendar.current.dateComponents([.weekday], from: Date().self).weekday!)-1]
//                        )
//                        .foregroundColor(.black)
//                        .font(.system(size: 14))
//                        
//                    }
//                    if idx != weeklyDays.count - 1
//                    {
//                        Spacer()
//                    }
//                    
//                }
//                
//            }.padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
//                
//        }
//        
//    }
//    mutating func getCurrentWeek(){
//        let calendar: Calendar = .current
//        let now = Date()
//        let nowWeekDay = Calendar.current.dateComponents([.weekday], from: now)
//        print("now \(Int(nowWeekDay.weekday!)) ")
//        let endRange = (7-Int(nowWeekDay.weekday!) + 1)
//        let startRange = (Int(nowWeekDay.weekday!) - 2) * -1
//        
//        var startFromNow = Calendar.current.date(byAdding: .day, value: startRange, to: Date())
//        print("startFromNow \(startFromNow)")
//        let endFromNow = calendar.date(byAdding: .day, value: endRange, to: now)!
//        if currentWeek.isEmpty {
//            currentWeek.append(startFromNow)
//        }
//        
//        print(currentWeek)
//        var interval: TimeInterval = 0
////        guard calendar.dateInterval(of: .weekOfMonth, start: &(startFromNow)!, interval: &interval, for: weekFromNow) else { return }
//        
//        print("inizio \(String(describing: startFromNow)) e fine \(endFromNow)")
//        return
//    }
//    
//}
//
//struct MyCalendarWeeklyView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyCalendarWeeklyView()
//    }
//}

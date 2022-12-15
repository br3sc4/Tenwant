//
//  Calendar.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 14/12/22.
//

import Foundation
import UIKit
import SwiftUI

class CalendarViewController: UIViewController, UICalendarSelectionMultiDateDelegate{
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        print("Selected Date:", dateComponents)
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        //        print("De-Selected Date:", dateComponents)
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureCalendarView() {
        let calendarView = UICalendarView()
        
        
        calendarView.calendar = Calendar(identifier: .gregorian)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let now = Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
        
        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: now.year! - 5, month: 1, day: 1)
        let toDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: now.year! + 5, month: 12, day: 31)
        
        guard let fromDate = fromDateComponents.date, let toDate = toDateComponents.date else {
            return
        }
        
        let calendarViewDateRange = DateInterval(start: fromDate, end: toDate)
        calendarView.availableDateRange = calendarViewDateRange
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: now.year, month: now.month, day: now.day)
        
        //        let multiDateSelection = UICalendarSelectionMultiDate(delegate: self)
        _ = UICalendarSelectionMultiDate(delegate: self)
        calendarView.delegate = self
    }
    
    
    
}
extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    //    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
    ////        let font = UIFont.systemFont(ofSize: 9)
    ////            let configuration = UIImage.SymbolConfiguration(font: font)
    ////            let image = UIImage(systemName: "star.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal)
    ////            return .image(image)
    //        return
    //    }
}


//
//  AlertContent.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import Foundation

struct AlertContent {
    let title: String
    let message: String
    
    init(title: String = "", message: String = "") {
        self.title = title
        self.message = message
    }
}

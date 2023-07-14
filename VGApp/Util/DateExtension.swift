//
//  DateExtension.swift
//  VGApp
//
//  Created by Kiara on 14.07.23.
//

import Foundation

extension Date {
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE dd. HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}

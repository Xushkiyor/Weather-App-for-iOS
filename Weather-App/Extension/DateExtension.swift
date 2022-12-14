//
//  DateExtension.swift
//  Wheather App with Xib
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 14/12/22.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}

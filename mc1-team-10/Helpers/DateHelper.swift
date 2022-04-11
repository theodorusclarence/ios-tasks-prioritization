//
//  DateHelper.swift
//  mc1-team-10
//
//  Created by Clarence on 11/04/22.
//

import Foundation

class DateHelper {
    func getStringDate(_ date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d MMMM YYYY"
        return dateFormatterGet.string(from: date)
    }
}

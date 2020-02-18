//
//  Utils.swift
//  VitalDays
//
//  Created by Junyu Lin on 3/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class Utils{
    
    static var shard: Utils = Utils()
    
    func showError(title: String, _ error: String, _ vc: UIViewController){
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
    
    var selectedDate: Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone?
        return formatter.date(from: self)
    }
}

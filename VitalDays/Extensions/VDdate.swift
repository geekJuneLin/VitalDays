//
//  VDdate.swift
//  VitalDays
//
//  Created by Junyu Lin on 29/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import Foundation

var date = Date()
var calendar = Calendar.current
var day = calendar.component(.day, from: date)
var year = calendar.component(.year, from: date)
var month = calendar.component(.month, from: date)
var weekday = calendar.component(.weekday, from: date)

let weeks = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
let daysInMonths = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
let months = ["January", "February", "March", "April", "May", "June", "July", "Augest", "September", "October", "November", "December"]

struct VDdate {
    var day: Int
    var month: Int
    var year: Int
}

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

class VDdate{
    
//    private static var date = Date()
//    private var day: Int
//    private var year: Int
//    private var month: Int
//    private var weekday: Int
//    private static var calendar = Calendar.current
//    private static let weeks = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//    private static let daysInMonths = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
//    private static let months = ["January", "February", "March", "April", "May", "June", "July", "Augest", "September", "October", "November", "December"]
//
//    init(<#parameters#>) {
//        <#statements#>
//    }
//
//    static func getDay() -> Int {
//        return calendar.component(.day, from: date)
//    }
//
//    static func getYear() -> Int {
//        return calendar.component(.year, from: date)
//    }
//
//    static func getMonth() -> Int {
//        return calendar.component(.month, from: date)
//    }
//
//    static func setMonth(n: Int){
//
//    }
//
//    static func getWeekday() -> Int {
//        return calendar.component(.weekday, from: date)
//    }
//
//    static func getWeek(index: Int) -> String{
//        return weeks[index]
//    }
//
//    static func getDaysInMonths(index: Int) -> Int {
//        return daysInMonths[index]
//    }
//
//    static func getMonths(index: Int) -> String {
//        return months[index]
//    }
}

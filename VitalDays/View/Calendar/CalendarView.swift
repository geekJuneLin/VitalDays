//
//  CalendarView.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

var date = Date()
var calendar = Calendar.current
var day = calendar.component(.day, from: date)
var year = calendar.component(.year, from: date)
var month = calendar.component(.month, from: date)
var weekdayOrdinal = calendar.component(.weekdayOrdinal, from: date)

let weeks = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
let daysInMonths = [30, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
let months = ["January", "February", "March", "April", "May", "June", "July", "Augest", "September", "October", "November", "December"]

class CalendarView: UIView{
    
    let yearView: CalendarYear = {
        let view = CalendarYear()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weekView: CalendarWeek = {
       let view = CalendarWeek()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let daysView: CalendarDays = {
        let view = CalendarDays()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        print("\(weekdayOrdinal) \(day) \(month) \(year)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        yearView.updateDelegate = daysView
        
        addSubviews(yearView, weekView, daysView)
        
        yearView.anchors(centerX: centerXAnchor,
                         top: topAnchor,
                         width: widthAnchor,
                         widthValue: 1,
                         heightValue: 30)
        
        weekView.anchors(top: yearView.bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         heightValue: 40)
        
        daysView.anchors(top: weekView.bottomAnchor,
                         topConstant: 8,
                         bottom: bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor)
    }
}

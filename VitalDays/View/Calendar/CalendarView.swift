//
//  CalendarView.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

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
    
    private var selectedDay: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        selectedDay = day
        print("\(weekday) \(day) \(month) \(year)")
        daysView.passDayDelegate = self
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

        daysView.anchors(centerX: centerXAnchor,
                         top: weekView.bottomAnchor,
                         topConstant: 8,
                         bottom: bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor)
    }
}

// MARK: - public function
extension CalendarView {
    
    func getSelectedDate() -> VDdate{
        return VDdate(day: selectedDay!, month: month, year: year)
    }
}

// MARK: - delegate methods
extension CalendarView: PassDayDelegate{
    func selectedDay(day: Int) {
        print("CalendarView select: \(day)")
        selectedDay = day
    }
}

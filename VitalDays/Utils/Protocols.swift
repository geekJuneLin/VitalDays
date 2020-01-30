//
//  Protocols.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

protocol ShowSlideMenuDelegate {
    func showSlideMenu(isDisplayed: Bool)
}

protocol UpdateCalendarDaysDelegate {
    func update()
}

protocol SaveVitalDayDelegate {
    func saveVitalDay(event: String)
}

protocol TypeSelectedDelegate {
    func selectedType(type: String)
}

protocol RepeatSelectedDelegate {
    func selectedRepeat(type: String)
}

protocol PassDayDelegate {
    func selectedDay(day: Int)
}

protocol PassSelectedDateDelegate {
    func selectedDate(date: VDdate)
}

protocol PassTextFieldValueDelegate {
    func textFieldValue(value: String)
}

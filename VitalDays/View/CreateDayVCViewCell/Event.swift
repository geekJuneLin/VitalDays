//
//  Event.swift
//  VitalDays
//
//  Created by Junyu Lin on 30/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import Foundation

enum NoteType: Int{
    case 倒计时
    case 纪念日
    case 生日
    case 作业
}

struct Event{
    var note: String
    var noteType: NoteType
    var targetDate: String
    var leftDays: Int
}

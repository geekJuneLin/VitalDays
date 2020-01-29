//
//  File.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CalendarYear: UIView{
    
    var updateDelegate: UpdateCalendarDaysDelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "\(months[month - 1]) \(year)"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "left-arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "right-arrow"), for: .normal)
        button.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        addSubviews(label, leftBtn, rightBtn)
        
        label.anchors(centerX: centerXAnchor,
                      centerY: centerYAnchor)
        
        leftBtn.anchors(centerY: centerYAnchor,
                        left: leftAnchor,
                        leftConstant: 10,
                        widthValue: 25,
                        heightValue: 25)
        
        rightBtn.anchors(centerY: centerYAnchor,
                         right: rightAnchor,
                         rightConstant: -10,
                         widthValue: 25,
                         heightValue: 25)
    }
}

// MARK: - objc selector functions
extension CalendarYear{
    @objc
    fileprivate func handleLeftButton(){
        print("left button clicked")
        if month == 1 {
            month = 12
            year -= 1
            label.text = "\(months[month - 1]) \(year)"
        }else{
            month -= 1
            label.text = "\(months[month - 1]) \(year)"
        }
        
        var emptyBox = Int()
        let boxAtEnd = (7 - CalendarDays.getCurrEmptyBox()) + ((!CalendarDays.checkLeapYear() && month == 2) ? 28 : daysInMonths[month - 1])
        if boxAtEnd > 35 {
            emptyBox = 42 - boxAtEnd
        }else if boxAtEnd > 25{
            emptyBox = 35 - boxAtEnd
        }
        CalendarDays.setCurrEmptyBox(box: emptyBox)

        updateDelegate?.update()
    }
    
    @objc
    fileprivate func handleRightButton(){
        print("right button clicked")
        var emptyBox = Int()
        let boxAtEnd = CalendarDays.getCurrEmptyBox() + ((!CalendarDays.checkLeapYear() && month == 2) ? 28 : daysInMonths[month - 1])
        if boxAtEnd > 35 {
            emptyBox = 7 - (42 - boxAtEnd)
        }else if boxAtEnd > 25 {
            emptyBox = 7 - (35 - boxAtEnd)
        }
        if emptyBox == 7 {emptyBox = 0 }
        CalendarDays.setCurrEmptyBox(box: emptyBox)

        if month == 12 {
            month = 1
            year += 1
            label.text = "\(months[month - 1]) \(year)"
        }else{
            month += 1
            label.text = "\(months[month - 1]) \(year)"
        }
        if weekday == 0 { weekday = 7 }
        
        updateDelegate?.update()
    }
}

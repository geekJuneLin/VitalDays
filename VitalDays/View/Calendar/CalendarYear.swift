//
//  File.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CalendarYear: UIView{
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "left-arrow"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "right-arrow"), for: .normal)
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

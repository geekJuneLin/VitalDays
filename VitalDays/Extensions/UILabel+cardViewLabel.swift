//
//  UILabel+cardViewLabel.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CardViewLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
        self.font = UIFont.init(name: "Arial", size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextWithFont(text: String, font: UIFont){
        self.font = font
        self.text = text
    }
}

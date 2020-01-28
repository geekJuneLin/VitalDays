//
//  UITextField+underline.swift
//  VitalDays
//
//  Created by Junyu Lin on 28/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

extension UITextField{
    
    func underline(color: UIColor){
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 32, width: UIScreen.main.bounds.width * 0.8, height: 1)
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        self.layer.addSublayer(layer)
    }
}

//
//  UserInfoViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 6/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class UserInfoViewCell: UICollectionViewCell{
    
    let nameLbl: UILabel = {
       let label = UILabel()
        label.text = "名字"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let name: UILabel = {
       let label = UILabel()
        label.text = "JJ"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        addSubviews(nameLbl, name)
        
        nameLbl.anchors(centerY: centerYAnchor,
                        left: leftAnchor,
                        leftConstant: 6)
        
        name.anchors(centerY: centerYAnchor,
                     right: rightAnchor,
                     rightConstant: -6)
    }
}

//
//  SettingTableViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 1/03/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell{
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "推送消息"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let content: UILabel = {
        let label = UILabel()
        label.text = "1.0.0"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let icon: UIImageView = {
       let view = UIImageView()
        let image = UIImage(named: "right-arrow")
        view.image = image
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        addSubviews(label, icon, content)
        
        label.anchors(centerY: centerYAnchor,
                      left: leftAnchor,
                      leftConstant: 20)
        
        content.anchors(centerY: centerYAnchor,
                        right: rightAnchor,
                        rightConstant: -18)
        
        icon.anchors(centerY: centerYAnchor,
                     right: rightAnchor,
                     rightConstant: -10,
                     widthValue: 25,
                     heightValue: 25)
    }
}

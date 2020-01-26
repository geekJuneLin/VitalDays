//
//  SlideMenuTableViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell{
    
    var menuItem: MenuItem?{
        didSet{
            if let item = menuItem{
                iconImg.image = UIImage(named: item.image)
                label.text = item.text
            }
        }
    }
    
    let iconImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    let selectedView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
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
        self.backgroundColor = .backgroundColor
        selectedView.frame = self.bounds
        self.selectedBackgroundView = selectedView
        
        self.addSubviews(iconImg, label)
        
        iconImg.anchors(centerY: centerYAnchor, left: leftAnchor, leftConstant: 12, widthValue: 25, heightValue: 25)
        label.anchors(centerY: centerYAnchor, left: iconImg.rightAnchor, leftConstant: 8)
    }
}

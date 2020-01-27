//
//  CalendarDaysViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CalendarDaysViewCell: UICollectionViewCell{
    
    let roundedView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    override var isSelected: Bool{
        didSet{
            roundedView.isHidden = !isSelected
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupView(){
        addSubviews(roundedView, label)
        
        roundedView.fillUpSuperView()
        label.centerInSuper()
    }
}


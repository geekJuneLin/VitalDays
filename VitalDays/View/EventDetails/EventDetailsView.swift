//
//  EventDetailsView.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class EventDetailsView: UIView{
    
    var event: Event? {
        didSet{
            if let event = event {
                title.text = event.note
                daysLeft.text = "\(event.leftDays)"
                targetDate.text = event.targetDate
            }
        }
    }
    
    let top: UIView = {
       let view = UIView()
        view.backgroundColor = .systemTeal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let title: UILabel = {
       let label = UILabel()
        label.text = "宝贝回来"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let daysLeft: UILabel = {
       let label = UILabel()
        label.text = "5"
        label.textColor = .white
        label.font = UIFont.init(name: "Courier", size: 85)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separator: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let targetDateView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let targetDateTitle: UILabel = {
       let label = UILabel()
        label.text = "目标日："
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let targetDate: UILabel = {
       let label = UILabel()
        label.text = "2020-2-24"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        addSubviews(top, daysLeft, separator, targetDateView)
        top.addSubviews(title)
        
        top.anchors(centerX: centerXAnchor,
                    width: widthAnchor,
                    widthValue: 1,
                    height: heightAnchor,
                    heightValue: 0.18)
        
        title.centerInSuper()
        
        daysLeft.anchors(centerX: centerXAnchor,
                         centerY: centerYAnchor)
        
        separator.anchors(centerX: centerXAnchor,
                          bottom: targetDateView.topAnchor,
                          bottomConstant: -10,
                          width: widthAnchor,
                          widthValue: 0.9,
                          heightValue: 0.8)
        
        targetDateView.anchors(centerX: centerXAnchor,
                               bottom: bottomAnchor,
                               bottomConstant: -10,
                               width: widthAnchor,
                               widthValue: 0.8,
                               height: heightAnchor,
                               heightValue: 0.12)
        
        targetDateView.addSubviews(targetDateTitle, targetDate)
        
        targetDateTitle.anchors(centerX: targetDateView.centerXAnchor,
                                XConstant: -40,
                                centerY: targetDateView.centerYAnchor)
        
        targetDate.anchors(centerX: targetDateView.centerXAnchor,
                           XConstant: 40,
                           centerY: targetDateView.centerYAnchor)
    }
}

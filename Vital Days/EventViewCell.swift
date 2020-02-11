//
//  EventViewCell.swift
//  Vital Days
//
//  Created by Junyu Lin on 11/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class EventViewCell: UICollectionViewCell{
    
    var event: Event? {
        didSet{
            if let event = event {
                noteType.text = " \(event.noteType) "
                note.text = event.note
                targetDate.text = event.targetDate
                dayLeft.text = "\(event.leftDays)"
            }
        }
    }
    
    let noteType: UILabel = {
       let label = UILabel()
        label.text = " 倒计时 "
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .systemTeal
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let note: UILabel = {
       let label = UILabel()
        label.text = "宝贝回来"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let targetDateTitle: UILabel = {
       let label = UILabel()
        label.text = "目标日："
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let targetDate: UILabel = {
       let label = UILabel()
        label.text = "2020-3-1"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLeftTitle: UILabel = {
       let label = UILabel()
        label.text = "剩余天数"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dayLeft: UILabel = {
       let label = UILabel()
        label.text = "19"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .darkText
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
        addSubviews(noteType, note, targetDateTitle, targetDate, dayLeftTitle, dayLeft)
        
        noteType.anchors(top: topAnchor,
                         topConstant: 8,
                         left: leftAnchor,
                         leftConstant: 10)
        
        note.anchors(top: noteType.bottomAnchor,
                     topConstant: 2,
                     left: noteType.leftAnchor)
        
        targetDateTitle.anchors(top: note.bottomAnchor,
                                topConstant: 2,
                                left: note.leftAnchor)
        
        targetDate.anchors(top: targetDateTitle.topAnchor,
                           left: targetDateTitle.rightAnchor,
                           leftConstant: 2)
        
        dayLeftTitle.anchors(centerY: noteType.centerYAnchor,
                             right: rightAnchor,
                             rightConstant: -10)
        
        dayLeft.anchors(centerX: dayLeftTitle.centerXAnchor,
                        top: dayLeftTitle.bottomAnchor,
                        topConstant: 2)
    }
}

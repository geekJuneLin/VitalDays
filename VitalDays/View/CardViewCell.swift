//
//  CardViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell{
    
    let noteLbl: CardViewLabel = {
       let label = CardViewLabel()
        label.setTextWithFont(text: "WWDC", font: UIFont.init(name: "Arial", size: 20)!)
        return label
    }()
    
    let noteTypeLbl: CardViewLabel = {
       let label = CardViewLabel()
        label.setTextWithFont(text: "倒计时", font: UIFont.init(name: "Arial", size: 20)!)
        return label
    }()
    
    let smallTypeLbl: CardViewLabel = {
       let label = CardViewLabel()
        label.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        label.textColor = UIColor.black.withAlphaComponent(0.1)
        label.clipsToBounds = true
        label.layer.cornerRadius = 2
        label.setTextWithFont(text: " 倒计时 ", font: UIFont.init(name: "Arial", size: 12)!)
        return label
    }()
    
    let targetLbl: CardViewLabel = {
       let label = CardViewLabel()
        label.text = "目标日："
        return label
    }()
    
    let targetDayLbl: CardViewLabel = {
       let label = CardViewLabel()
        label.text = "2020 - 2 - 5"
        return label
    }()
    
    let countDownLbl: CardViewLabel = {
       let label = CardViewLabel()
        label.text = "剩余天数"
        return label
    }()
    
    let countDownDays: CardViewLabel = {
       let label = CardViewLabel()
        label.setTextWithFont(text: "13", font: UIFont(name: "Courier", size: 30)!)
        return label
    }()
    
    let progress: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bar: UIView = {
       let bar = UIView()
        bar.backgroundColor = .barColor
        bar.layer.shadowColor = UIColor.gray.cgColor
        bar.layer.shadowOffset = .zero
        bar.layer.shadowRadius = 5
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 8
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        addSubviews(noteLbl, noteTypeLbl, smallTypeLbl, targetLbl, targetDayLbl, countDownLbl, countDownDays, progress)
        
        noteLbl.anchors(top: topAnchor, topConstant: 15, left: leftAnchor, leftConstant: 15)
        noteTypeLbl.anchors(centerY: noteLbl.centerYAnchor, left: noteLbl.rightAnchor, leftConstant: 8)
        smallTypeLbl.anchors(top: noteLbl.bottomAnchor, topConstant: 10, left: noteLbl.leftAnchor)
        targetLbl.anchors(top: smallTypeLbl.bottomAnchor, topConstant: 10, left: noteLbl.leftAnchor)
        targetDayLbl.anchors(top: targetLbl.topAnchor, left: targetLbl.rightAnchor, leftConstant: 10)
        countDownLbl.anchors(top: noteLbl.topAnchor, right: rightAnchor, rightConstant: -15)
        countDownDays.anchors(centerX: countDownLbl.centerXAnchor, top: countDownLbl.bottomAnchor, topConstant: 10)
        progress.anchors(top: targetLbl.bottomAnchor, topConstant: 15, left: targetLbl.leftAnchor, right: countDownLbl.rightAnchor, heightValue: 15)
        
        progress.addSubview(bar)
        bar.anchors(left: progress.leftAnchor,
                    width: progress.widthAnchor,
                    widthValue: 0.4,
                    height: progress.heightAnchor,
                    heightValue: 1)
    }
}

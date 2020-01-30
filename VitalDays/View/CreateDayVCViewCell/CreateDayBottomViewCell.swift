//
//  CreateDayBottomViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayBottomViewCell: UICollectionViewCell{
    
    var event: Event?{
        didSet{
            if let event = event {
                cardView.noteLbl.text = event.note
                cardView.noteTypeLbl.text = event.noteType
                cardView.smallTypeLbl.text = " \(event.noteType) "
                cardView.targetDayLbl.text = event.targetDate
                cardView.countDownDays.text = "\(event.leftDays)"
            }
        }
    }
    
    let cellLabel: UILabel = {
      let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "效果预览:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardView: CardView = {
       let view = CardView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        addSubviews(cellLabel, cardView)
        
        cellLabel.anchors(top: topAnchor,
                          topConstant: 4,
                          left: leftAnchor)
        
        cardView.anchors(centerX: centerXAnchor,
                         top: cellLabel.bottomAnchor,
                         topConstant: 16,
                         width: widthAnchor,
                         widthValue: 0.95,
                         height: heightAnchor,
                         heightValue: 0.45)
    }
}

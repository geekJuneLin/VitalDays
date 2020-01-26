//
//  CardViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell{
    
    let cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        addSubview(cardView)
        
        cardView.anchors(centerX: centerXAnchor,
                         centerY: centerYAnchor,
                         width: widthAnchor,
                         widthValue: 1,
                         height: heightAnchor,
                         heightValue: 1)
    }
}

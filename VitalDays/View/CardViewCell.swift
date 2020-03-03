//
//  CardViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell{
    
    var event: Event?{
        didSet{
            if let event = event {
                cardView.event = event
            }
        }
    }
    
    var selectedIndex: Int?
    
    var deleteDelegate: DeleteDelegate?
    
    let cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deleteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "cross"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 15
        btn.tintColor = .black
        btn.isHidden = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// start shaking animation and impact the feedback
    func shake() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    fileprivate func setupViews(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        addSubviews(cardView, deleteBtn)
        
        cardView.anchors(centerX: centerXAnchor,
                         centerY: centerYAnchor,
                         width: widthAnchor,
                         widthValue: 1,
                         height: heightAnchor,
                         heightValue: 1)
        
        deleteBtn.anchors(top: topAnchor,
                          topConstant: 10,
                          right: rightAnchor,
                          rightConstant: -10,
                          widthValue: 30,
                          heightValue: 30)
        
        deleteBtn.addTarget(self, action: #selector(handleDeleteBtn), for: .touchUpInside)
    }
    
    @objc
    fileprivate func handleDeleteBtn(){
        print("delete btn pressed!")
        deleteBtn.isHidden = true
        deleteDelegate?.deleteEvent(event: event!, index: selectedIndex!)
    }
}

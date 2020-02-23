//
//  EventDetailsViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class EventDetailsViewCell: UICollectionViewCell{
    
    var shareDelegate: ShareEventDelegate?
    
    var event: Event? {
        didSet{
            if let event = event {
                eventView.event = event
            }
        }
    }
    
    let eventView: EventDetailsView = {
       let view = EventDetailsView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shareBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("分享", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        // set action
        shareBtn.addTarget(self, action: #selector(handleShareBtnClick), for: .touchUpInside)
        
        addSubviews(eventView, shareBtn)
        
        eventView.anchors(centerX: centerXAnchor,
                          top: topAnchor,
                          topConstant: bounds.height * 0.15,
                          width: widthAnchor,
                          widthValue: 0.9,
                          height: heightAnchor,
                          heightValue: 0.4)
        
        shareBtn.anchors(centerX: centerXAnchor,
                         top: eventView.bottomAnchor,
                         topConstant: 36,
                         width: eventView.widthAnchor,
                         widthValue: 0.6,
                         heightValue: 36)
    }
    
    @objc
    fileprivate func handleShareBtnClick(){
        print("share btn pressed!")
        shareDelegate?.presentShareOptions()
    }
}

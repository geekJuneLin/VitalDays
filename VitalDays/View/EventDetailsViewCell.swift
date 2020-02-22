//
//  EventDetailsViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class EventDetailsViewCell: UICollectionViewCell{
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        addSubviews(eventView)
        
        eventView.anchors(width: widthAnchor,
                          widthValue: 0.9,
                          height: heightAnchor,
                          heightValue: 0.4)
        eventView.centerInSuper()
    }
}

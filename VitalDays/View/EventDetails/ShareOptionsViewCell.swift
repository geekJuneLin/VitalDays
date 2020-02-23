//
//  ShareOptionsViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class ShareOptionsViewCell: UICollectionViewCell{
    
    var option: ShareOptions?{
        didSet{
            if let option = option {
                image.image = UIImage(named: option.image)
                title.text = option.title
            }
        }
    }
    
    let image: UIImageView = {
       let v = UIImageView()
        v.image = UIImage(named: "dinosaur")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "微信"
        label.font = UIFont.systemFont(ofSize: 14)
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
        clipsToBounds = true
        layer.cornerRadius = 10
        
        addSubviews(image, title)
        
        image.anchors(centerY: centerYAnchor,
                      left: leftAnchor,
                      leftConstant: 16,
                      widthValue: 36,
                      heightValue: 36)
        
        title.anchors(centerY: centerYAnchor,
                      left: image.rightAnchor,
                      leftConstant: 16)
    }
}

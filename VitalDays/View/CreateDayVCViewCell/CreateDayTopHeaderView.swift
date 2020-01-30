//
//  CreateDayTopViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayTopHeaderView: UICollectionReusableView{
    
    var textFieldPassDelegate: PassTextFieldValueDelegate?
    
    var iconName: String?{
        didSet{
            if let icons = iconName{
                icon.image = UIImage(named: icons)
            }
        }
    }
    
    var cellLabel: String?{
        didSet{
            if let cellLabel = cellLabel{
                label.text = cellLabel
            }
        }
    }
    
    let icon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "dinosaur")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "种类"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let context: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contextTextField: UITextField = {
       let text = UITextField()
        text.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        text.isHidden = true
        text.placeholder = "点击这里输入备注"
        text.attributedPlaceholder = NSAttributedString(string: text.placeholder!, attributes: [.foregroundColor:UIColor.white])
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let arrowIcon: UIImageView = {
        let view  = UIImageView()
        view.image = UIImage(named: "right-arrow")
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
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        addSubviews(icon, label, context, contextTextField, arrowIcon)
        
        icon.anchors(centerY: centerYAnchor, left: leftAnchor, leftConstant: 8, widthValue: 25, heightValue: 25)
        label.anchors(centerY: centerYAnchor, left: icon.rightAnchor, leftConstant: 12)
        arrowIcon.anchors(centerY: centerYAnchor, right: rightAnchor, rightConstant: -12, widthValue: 25, heightValue: 25)
        context.anchors(centerY: centerYAnchor, right: arrowIcon.leftAnchor, rightConstant: -12)
        contextTextField.anchors(centerY: centerYAnchor, left: label.rightAnchor, leftConstant: 30)
    }
    
    @objc
    fileprivate func textDidChanged(){
        textFieldPassDelegate?.textFieldValue(value: contextTextField.text ?? "备注")
    }
}

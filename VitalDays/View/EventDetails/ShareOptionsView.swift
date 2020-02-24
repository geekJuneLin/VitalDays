//
//  ShareOptionsView.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class ShareOptionsView: UICollectionView{
    
    var dismissDelegate: DismissShareViewDelegate?
    
    let cellId = "cellId"
    let footerId = "footerId"
    
    let options = [ShareOptions(image: "weibo", title: "微博"),
                   ShareOptions(image: "wechat-colored", title: "微信"),
                   ShareOptions(image: "qq", title: "QQ")]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        dataSource = self
        delegate = self
        
        register(ShareOptionsViewCell.self, forCellWithReuseIdentifier: cellId)
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        backgroundColor = .white
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 15
    }
}

extension ShareOptionsView{
    @objc
    fileprivate func handleCancelBtn(){
        print("cancel btn pressed!")
        dismissDelegate?.dismissShareView()
    }
}

// MARK: - UICollectionViewDataSource
extension ShareOptionsView: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShareOptionsViewCell
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        cell.option = options[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId, for: indexPath)
            footer.clipsToBounds = true
            footer.backgroundColor = UIColor.black.withAlphaComponent(0.05)
            footer.layer.cornerRadius = 10
            let cancelBtn = UIButton(type: .system)
            cancelBtn.translatesAutoresizingMaskIntoConstraints = false
            cancelBtn.setTitle("取消", for: .normal)
            cancelBtn.setTitleColor(.black, for: .normal)
            cancelBtn.addTarget(self, action: #selector(handleCancelBtn), for: .touchUpInside)
            footer.addSubview(cancelBtn)
            cancelBtn.fillUpSuperView()
            return footer
        }else{
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShareOptionsView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.bounds.width - 20, height: 50)
        }else{
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: collectionView.frame.size.width - 20, height: 50)
        }else{
            return .zero
        }
    }
}

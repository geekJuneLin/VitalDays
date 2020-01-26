//
//  CreateDayViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayViewController: UICollectionViewController{
    
    let cellTopId = "cellTopId"
    let cellBottomId = "cellBottomId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationVC()
        setupView()
    }
    
    fileprivate func setupNavigationVC(){
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.topItem?.title = "Create the day"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        
        // setup left bar button item
        let leftBtn = UIButton(type: .system)
        leftBtn.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftBtn.tintColor = .white
        leftBtn.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
        let leftBarBtn = UIBarButtonItem(customView: leftBtn)
        let label = UILabel()
        label.text = "返回"
        label.textColor = .white
        let leftBarTitleBtn = UIBarButtonItem(customView: label)
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [leftBarBtn, leftBarTitleBtn]
        
        // setup right bar button item
        let rightBtn = UIButton(type: .system)
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: rightBtn)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarBtn
    }
    
    fileprivate func setupView(){
        // setup data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .backgroundColor
        
        collectionView.register(CreateDayTopViewCell.self, forCellWithReuseIdentifier: cellTopId)
        collectionView.register(CreateDayBottomViewCell.self, forCellWithReuseIdentifier: cellBottomId)
    }
}

// MARK: - objc selector functions
extension CreateDayViewController{
    @objc
    fileprivate func handleLeftButton(){
        print("left button clicked!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    fileprivate func handleRightButton(){
        print("right button clicked!")
    }
}

// MARK: - UICollectionViewController data source
extension CreateDayViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 4
        }else{
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTopId, for: indexPath)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBottomId, for: indexPath)
            cell.backgroundColor = .systemTeal
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CreateDayViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.bounds.width * 0.9, height: 70)
        }else{
            return CGSize(width: collectionView.bounds.width * 0.9, height: 320)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 36, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        }
    }
}

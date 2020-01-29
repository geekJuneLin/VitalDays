//
//  CreateDayViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayViewController: UICollectionViewController{
    
    var saveVitalDayDelegate: SaveVitalDayDelegate?
    
    var typeItems = 0
    var isTypeSelectViewPresented = false
    var repeatItems = 0
    var isRepeatSelectViewPresented = false
    
    let topHeaderId = "topHeaderId"
    let cellTypeId = "cellTypeId"
    let cellTargetId = "cellTargetId"
    let cellRepeatId = "cellRepeatId"
    let cellNoteId = "cellNoteId"
    let cellBottomId = "cellBottomId"
    
    let headerIcons = ["light", "target", "repeat", "note"]
    let headerLabels = ["种类", "目标日期", "循环提醒", "备注"]
    let headerContext = ["倒计时", "2020 - 1 - 29", "否", "宝贝回来"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationVC()
        setupView()
    }
    
    /// setup navigation view controller
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
    
    /// setup view
    fileprivate func setupView(){
        // setup data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .backgroundColor
        
        // top header view
        collectionView.register(CreateDayTopHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: topHeaderId)
        
        // child cell view
        collectionView.register(CreateDayTypeViewCell.self, forCellWithReuseIdentifier: cellTypeId)
        collectionView.register(CreateDayRepeatViewCell.self, forCellWithReuseIdentifier: cellRepeatId)
        collectionView.register(CreateDayBottomViewCell.self, forCellWithReuseIdentifier: cellBottomId)
    }
}

// MARK: - objc selector functions
extension CreateDayViewController{
    
    /// dismiss the current view controller
    @objc
    fileprivate func handleLeftButton(){
        print("left button clicked!")
        self.dismiss(animated: true, completion: nil)
    }
    
    /// save the day
    @objc
    fileprivate func handleRightButton(){
        print("right button clicked!")
        saveVitalDayDelegate?.saveVitalDay(event: "First Day")
    }
    
    /// present the date picker view controller
    @objc
    fileprivate func presentDatePickerViewController(){
        let calenderVC = CalendarPickerViewController()
        let navigationVC = UINavigationController(rootViewController: calenderVC)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    /// present the type select view
    @objc
    fileprivate func presentTypeSelectView(){
        isTypeSelectViewPresented.toggle()
        typeItems = isTypeSelectViewPresented ? 1 : 0
        isTypeSelectViewPresented ? collectionView.insertItems(at: [IndexPath(row: 0, section: 0)]) : collectionView.deleteItems(at: [IndexPath(row: 0, section: 0)])
        collectionView.reloadData()
    }
    
    /// present the repeat select view
    @objc
    fileprivate func presentRepeatSelectView(){
        isRepeatSelectViewPresented.toggle()
        repeatItems = isRepeatSelectViewPresented ? 1 : 0
        isRepeatSelectViewPresented ? collectionView.insertItems(at: [IndexPath(row: 0, section: 2)]) : collectionView.deleteItems(at: [IndexPath(row: 0, section: 2)])
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewController data source
extension CreateDayViewController{
    
    // number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    // number of items for each section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // for type select view
        if section == 0{
            return typeItems
        }
        
        // for repeat select view
        if section == 2{
            return repeatItems
        }
        
        // for preview cell
        if section == 4{
            return 1
        }
        
        return 0
    }
    
    // view cell at each index
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // type select view cell
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeId, for: indexPath)
            return cell
        }
        
        //  repeat select view cell
        if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRepeatId, for: indexPath)
            return cell
        }
        
        // preview view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBottomId, for: indexPath)
        return cell
    }
    
    // header supplementary view for each section
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: topHeaderId, for: indexPath) as! CreateDayTopHeaderView
                header.iconName = headerIcons[indexPath.section]
                header.cellLabel = headerLabels[indexPath.section]
                header.context.text = headerContext[indexPath.section]
            
            // TapReconizer for type select view cell
            if indexPath.section == 0{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentTypeSelectView)))
            }
            
            // TapReconizer for repeat select view cell
            if indexPath.section == 2{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentRepeatSelectView)))
            }
            
            // TapReconizer for date picker view controller
            if indexPath.section == 1{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentDatePickerViewController)))
            }
            return header
        }else{
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CreateDayViewController: UICollectionViewDelegateFlowLayout{
    
    // size for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 4{
            return CGSize(width: collectionView.bounds.width * 0.9, height: 320)
        }else{
            return CGSize(width: collectionView.bounds.width, height: 70)
        }
    }
    
    // size for header view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 4 {
            return .zero
        }
        return CGSize(width: collectionView.bounds.width * 0.9, height: 70)
    }
    
    // inset for each section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 4{
            return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

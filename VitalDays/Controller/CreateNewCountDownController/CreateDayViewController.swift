//
//  CreateDayViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 23/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayViewController: UICollectionViewController{
    
    // delegates
    var saveVitalDayDelegate: SaveVitalDayDelegate?
    
    var typeItems = 0
    var isTypeSelectViewPresented = false
    var repeatItems = 0
    var isRepeatSelectViewPresented = false
    var isTyping = false
    
    let topHeaderId = "topHeaderId"
    let cellTypeId = "cellTypeId"
    let cellTargetId = "cellTargetId"
    let cellRepeatId = "cellRepeatId"
    let cellNoteId = "cellNoteId"
    let cellBottomId = "cellBottomId"
    
    let headerIcons = ["light", "target", "repeat", "note"]
    let headerLabels = ["种类", "目标日期", "循环提醒", "备注:"]
    
    var selectedType = "选择类型"
    var selectedRepeat = "选择循环提醒"
    var selectedTargetDate = ""
    var noteTextFieldValue = ""
    var daysLeft = 0
    
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
        // add tap gesture
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        
        // setup data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .backgroundColor
        
        // top header view
        collectionView.register(CreateDayTopHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: topHeaderId)
        
        // child cell view
        collectionView.register(CreateDayTypeViewCell.self, forCellWithReuseIdentifier: cellTypeId)
        collectionView.register(CreateDayRepeatViewCell.self, forCellWithReuseIdentifier: cellRepeatId)
        collectionView.register(CreateDayBottomViewCell.self, forCellWithReuseIdentifier: cellBottomId)
    }
}

// MARK: - other functions
extension CreateDayViewController{
    fileprivate func showOrHideTypeView(){
        isTypeSelectViewPresented.toggle()
        typeItems = isTypeSelectViewPresented ? 1 : 0
        isTypeSelectViewPresented ? collectionView.insertItems(at: [IndexPath(row: 0, section: 0)]) : collectionView.deleteItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    fileprivate func showOrHideRepeatView(){
        isRepeatSelectViewPresented.toggle()
        repeatItems = isRepeatSelectViewPresented ? 1 : 0
        isRepeatSelectViewPresented ? collectionView.insertItems(at: [IndexPath(row: 0, section: 2)]) : collectionView.deleteItems(at: [IndexPath(row: 0, section: 2)])
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
        calenderVC.passSelectedDateDelegate = self
        let navigationVC = UINavigationController(rootViewController: calenderVC)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    /// present the type select view
    @objc
    fileprivate func presentTypeSelectView(){
        showOrHideTypeView()
    }
    
    /// present the repeat select view
    @objc
    fileprivate func presentRepeatSelectView(){
        showOrHideRepeatView()
    }
    
    @objc
    fileprivate func handleTapGesture(){
        print("tapped!")
        if !view.isFirstResponder { print("here we go!"); view.endEditing(true) }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTypeId, for: indexPath) as! CreateDayTypeViewCell
            cell.selectedTypeDelegate = self
            return cell
        }
        
        //  repeat select view cell
        if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRepeatId, for: indexPath) as! CreateDayRepeatViewCell
            cell.selectedRepeatDelegate = self
            return cell
        }
        
        // preview view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBottomId, for: indexPath) as! CreateDayBottomViewCell
        cell.event = Event(note: noteTextFieldValue == "" ? "备注" : noteTextFieldValue,
                           noteType: selectedType,
                           targetDate: selectedTargetDate,
                           leftDays: daysLeft)
        return cell
    }
    
    // header supplementary view for each section
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: topHeaderId, for: indexPath) as! CreateDayTopHeaderView
                header.iconName = headerIcons[indexPath.section]
                header.cellLabel = headerLabels[indexPath.section]
            
            // TapReconizer for type select view cell
            if indexPath.section == 0{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentTypeSelectView)))
                header.context.text = selectedType
                return header
            }
            // TapReconizer for date picker view controller
            else if indexPath.section == 1{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentDatePickerViewController)))
                header.context.text = selectedTargetDate
                return header
            }
            // TapReconizer for repeat select view cell
            else if indexPath.section == 2{
                header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentRepeatSelectView)))
                header.context.text = selectedRepeat
                return header
            }
            else if indexPath.section == 3{
                header.context.isHidden = true
                header.contextTextField.isHidden = false
                header.textFieldPassDelegate = self
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
        }
        if indexPath.section == 0 || indexPath.section == 2{
            return CGSize(width: collectionView.bounds.width, height: 120)
        }
        return .zero
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

// MARK: - delegate methods
extension CreateDayViewController: TypeSelectedDelegate, RepeatSelectedDelegate, PassSelectedDateDelegate, PassTextFieldValueDelegate{
    func selectedType(type: String) {
        print("create day VC: \(type)")

        
        showOrHideTypeView()
        selectedType = type
        collectionView.reloadSections(IndexSet(integer: 4))
        collectionView.reloadSections(IndexSet(integer: 0))
        
    }
    
    func selectedRepeat(type: String) {
        print("create day VC: \(type)")
        
        showOrHideRepeatView()
        selectedRepeat = type
        collectionView.reloadSections(IndexSet(integer: 2))
    }
    
    func selectedDate(date: VDdate) {
        print("date: \(date), \(Date()), \("\(date.year)-\(date.month)-\(date.day)".selectedDate!)")
        selectedTargetDate = "\(date.year)-\(date.month)-\(date.day)"
        daysLeft = calendar.dateComponents([.day, .hour],
                                           from: Date(),
                                           to: "\(date.year)-\(date.month)-\(date.day)".selectedDate!).day!
        collectionView.reloadSections(IndexSet(integer: 4))
        collectionView.reloadSections(IndexSet(integer: 1))
    }
    
    func textFieldValue(value: String) {
        noteTextFieldValue = value
        collectionView.reloadSections(IndexSet(integer: 4))
    }
}

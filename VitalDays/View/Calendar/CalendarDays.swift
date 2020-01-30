//
//  CalendarDays.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CalendarDays: UIView{
    
    // delegate
    var passDayDelegate: PassDayDelegate?
    
    let cellId = "cellId"
    
    static var emptyBox = Int()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 4
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        CalendarDays.emptyBox = CalendarDays.getEmptyBox()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CalendarDaysViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        
        collectionView.anchors(centerX: centerXAnchor,
                               top: topAnchor,
                               width: widthAnchor,
                               widthValue: 0.95,
                               height: heightAnchor,
                               heightValue: 0.9)
    }
}

// MARK: - other functions
extension CalendarDays{
    static func getCurrEmptyBox() -> Int{
        return emptyBox
    }
    
    static func setCurrEmptyBox(box: Int){
        emptyBox = box
    }
    
    static func getEmptyBox() -> Int{
        switch weekday{
        case 1:
            emptyBox = 6
        case 2:
            emptyBox = 0
        case 3:
            emptyBox = 1
        case 4:
            emptyBox = 2
        case 5:
            emptyBox = 3
        case 6:
            emptyBox = 4
        case 7:
            emptyBox = 5
        default:
            break
        }
        return emptyBox
    }
    
    static func checkLeapYear() -> Bool{
        return (year % 4) == 0 ?
            (year % 100) == 0 ?
                (year % 400) == 0 ?
                    true :
                false :
            true :
        false
    }
}

// MARK: - UICollectionView data source
extension CalendarDays: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(CalendarDays.checkLeapYear())")
        return (!CalendarDays.checkLeapYear() && month == 2) ? 28 + CalendarDays.emptyBox : daysInMonths[month - 1] + CalendarDays.emptyBox
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CalendarDaysViewCell
        cell.label.text = (indexPath.item >= CalendarDays.emptyBox) ? "\(indexPath.item - CalendarDays.emptyBox + 1)" : ""
        if (indexPath.item - CalendarDays.emptyBox + 1) == day &&
            month == Calendar.current.component(.month, from: Date()) &&
            year == Calendar.current.component(.year, from: Date()){
            cell.currentBack.isHidden = false
            print("select the current date")
        }else{
            cell.currentBack.isHidden = true
            cell.isClickable = (indexPath.item >= CalendarDays.emptyBox)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarDays: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 24) / 7, height: (collectionView.bounds.width - 24) / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        passDayDelegate?.selectedDay(day: indexPath.item - CalendarDays.emptyBox + 1)
    }
}

// MARK: - Update calendar delegate
extension CalendarDays: UpdateCalendarDaysDelegate{
    /// once users switch to next or previous month update the collectionview
    func update() {
        collectionView.reloadData()
    }
}

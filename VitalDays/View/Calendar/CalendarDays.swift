//
//  CalendarDays.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CalendarDays: UIView{
    let cellId = "cellId"
    
    private var emptyBox = Int()
    
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
                               width: widthAnchor,
                               widthValue: 0.95,
                               height: heightAnchor,
                               heightValue: 0.9)
    }
    
    fileprivate func getEmptyBox() -> Int{
        print("original: \(weekdayOrdinal)")
        switch weekdayOrdinal{
        case 0:
            emptyBox = 5
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
}

// MARK: - UICollectionView data source
extension CalendarDays: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyBox = getEmptyBox()
        print("empty: \(emptyBox)")
        return daysInMonths[month - 1] + emptyBox
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CalendarDaysViewCell
        cell.label.text = (indexPath.item >= emptyBox) ? "\(indexPath.item - emptyBox + 1)" : ""
        cell.isClickable = (indexPath.item >= emptyBox)
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
}

// MARK: - Update calendar delegate
extension CalendarDays: UpdateCalendarDaysDelegate{
    func update() {
        collectionView.reloadData()
    }
}

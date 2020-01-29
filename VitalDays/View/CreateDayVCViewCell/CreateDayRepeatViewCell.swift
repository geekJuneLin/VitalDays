//
//  CreateDayRepeatViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 29/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayRepeatViewCell: UICollectionViewCell{
    
    let repeatPickerView: UIPickerView = {
       let view = UIPickerView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let repeats = ["不重复", "周重复", "月重复", "年重复", "天重复"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        addSubviews(repeatPickerView)
        
        repeatPickerView.fillUpSuperView()
    }
    
    fileprivate func setupPickerView(){
        repeatPickerView.dataSource = self
        repeatPickerView.delegate = self
        repeatPickerView.setValue(UIColor.white, forKey: "textColor")
    }
}

// MARK: - UIPickerView data source
extension CreateDayRepeatViewCell: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        repeats.count
    }
}

// MARK: - UIPickerView delegate
extension CreateDayRepeatViewCell: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repeats[row]
    }
}

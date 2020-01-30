//
//  CreateDayTopTypeViewCell.swift
//  VitalDays
//
//  Created by Junyu Lin on 29/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CreateDayTypeViewCell: UICollectionViewCell{
    
    var selectedTypeDelegate: TypeSelectedDelegate?
    
    let typePickerView: UIPickerView = {
       let view = UIPickerView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let types = ["倒计时", "纪念日", "生日", "作业"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        addSubviews(typePickerView)
        
        typePickerView.fillUpSuperView()
    }
    
    fileprivate func setupPickerView(){
        typePickerView.dataSource = self
        typePickerView.delegate = self
        typePickerView.setValue(UIColor.white, forKey: "textColor")
    }
    
}

// MARK: - UIPickerView data source
extension CreateDayTypeViewCell: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - UIPickerView delegate
extension CreateDayTypeViewCell: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("type selected: \(types[row])")
        selectedTypeDelegate?.selectedType(type: types[row])
    }
}

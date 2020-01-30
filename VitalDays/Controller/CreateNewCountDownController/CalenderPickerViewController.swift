//
//  CalenderPickerViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 27/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class CalendarPickerViewController: UIViewController{
    
    // delegate
    var passSelectedDateDelegate: PassSelectedDateDelegate?
    
    let calendar: CalendarView = {
       let view = CalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    }
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.topItem?.title = "选择日期"
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
        view.backgroundColor = .backgroundColor
        
        view.addSubview(calendar)
        calendar.anchors(centerX: view.centerXAnchor,
                         top: view.safeAreaLayoutGuide.topAnchor,
                         width: view.widthAnchor,
                         widthValue: 1,
                         height: view.heightAnchor,
                         heightValue: 0.5)
    }
}

extension CalendarPickerViewController{
    
    @objc
    fileprivate func handleLeftButton(){
        print("left button clicked in Calendar")
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    fileprivate func handleRightButton(){
        print("right button clicked in Calendar: \(calendar.getSelectedDate())")
        passSelectedDateDelegate?.selectedDate(date: calendar.getSelectedDate())
        dismiss(animated: true, completion: nil)
    }
}

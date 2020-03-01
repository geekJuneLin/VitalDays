//
//  SettingsViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 1/03/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController{
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    let general = ["推送消息"]
    let about = ["版本信息", "给予好评", "推荐给朋友"]
    
    let dismissBtn: UIBarButtonItem = {
       let img = UIImage(named: "back")
        let btn = UIBarButtonItem()
        btn.image = img
        btn.tintColor = .white
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableview()
        setNavigation()
    }
    
    fileprivate func setupView(){
        tableView.backgroundColor = .backgroundColor
        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func setupTableview(){
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)
    }
    
    fileprivate func setNavigation(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        dismissBtn.target = self
        dismissBtn.action = #selector(handleDimissBtn)
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = dismissBtn
    }
}

// MARK: - other functions
extension SettingsViewController{
    @objc
    fileprivate func handleDimissBtn(){
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewController data source
extension SettingsViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return general.count
        }
        if section == 1{
            return about.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingTableViewCell
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        
        if indexPath.section == 0{
            cell.label.text = general[indexPath.item]
        }
        if indexPath.section == 1{
            if indexPath.item == 0{
                cell.content.isHidden = false
                cell.icon.isHidden = true
            }
            cell.label.text = about[indexPath.item]
        }
        
        // set selected backgroun color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        if section == 0{
            header?.textLabel?.text = "通用"
        }
        
        if section == 1{
            header?.textLabel?.text = "关于"
        }
        return header
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//
//  SlideMenuViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import Firebase

struct MenuItem {
    var text: String
    var image: String
}

class SlideMenuViewController: UIViewController{
    
    let cellId = "cellId"
    let menuItems = [MenuItem(text: "我的账号", image: "user"),
                     MenuItem(text: "更多", image: "info"),
                     MenuItem(text: "设置", image: "settings")]
    
    let iconImg: UIImageView = {
        let img = UIImage(named: "dinosaur")
        let view = UIImageView(image: img)
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bar: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
       let view = UITableView()
        view.backgroundColor = .backgroundColor
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableViewDelegate()
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .backgroundColor
        
        view.addSubviews(iconImg, bar, tableView)
        
        iconImg.anchors(top: view.safeAreaLayoutGuide.topAnchor,
                        topConstant: 15,
                        left: view.leftAnchor,
                        leftConstant: 45,
                        widthValue: 60,
                        heightValue: 60)
        
        bar.anchors(centerX: iconImg.centerXAnchor,
                    top: iconImg.bottomAnchor,
                    topConstant: 15,
                    widthValue: 120,
                    heightValue: 1)
        
        tableView.anchors(centerX: iconImg.centerXAnchor,
                          top: bar.bottomAnchor,
                          topConstant: 20,
                          widthValue: 150,
                          heightValue: view.bounds.height * 0.6)
        
        // gesture reconizer
        iconImg.isUserInteractionEnabled = true
        iconImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    fileprivate func setupTableViewDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        
        tableView.register(SlideMenuTableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - objc functions
extension SlideMenuViewController{
    /// present the images picker view controller
    @objc
    fileprivate func handleTapGesture(){
        print("icon pressed!")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .savedPhotosAlbum
        
        self.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UITableView data source
extension SlideMenuViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SlideMenuTableViewCell
        cell.menuItem = menuItems[indexPath.item]
        return cell
    }
}

// MARK: - UITableView delegate
extension SlideMenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            // check if the user current signed in
            if Auth.auth().currentUser != nil{
                print("My account: signed in")
                present(UserInfoViewController(), animated: true, completion: nil)
            }else{
                print("My account: not signed in")
                present(LoginViewController(), animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UIImagePickerController delegate
extension SlideMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage{
            // set the avator image
            iconImg.image = image
            
            // dismiss current VC
            dismiss(animated: true, completion: nil)
        }
    }
}

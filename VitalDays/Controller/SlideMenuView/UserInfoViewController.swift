//
//  UserInfoViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 5/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UserInfoViewController: UIViewController{
    
    let cellId = "cellId"
    
    @objc private var user: User?{
        didSet{
            infoCollectionView.reloadData()
        }
    }
    
    private var ref = Database.database().reference()
    
    let avator: UIImageView = {
       let view = UIImageView(image: UIImage(named: "dinosaur"))
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saperator: UIView = {
       let v = UIView()
        v.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let infoCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .backgroundColor
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let signOutBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign out", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        btn.addTarget(self, action: #selector(handleSignOutBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addObservers()
        fetchTheUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        user?.removeObserver(self, forKeyPath: "name")
        user?.removeObserver(self, forKeyPath: "email")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User()
        setupViews()
        setupCollectionView()
    }
    
    fileprivate func addObservers(){
        user?.addObserver(self, forKeyPath: "name", options: [.new], context: nil)
        user?.addObserver(self, forKeyPath: "email", options: [.new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "name"{
            let cell = infoCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! UserInfoViewCell
            cell.name.text = "\(change?[.newKey] as! String)"
            infoCollectionView.reloadData()
            print("\(change?[.newKey] as! String)")
        }
        
        if keyPath == "email"{
//            let cell = infoCollectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! UserInfoViewCell
//            cell.name.text = "\(change?[.newKey] as! String)"
//            infoCollectionView.reloadData()
            print("\(change?[.newKey] as! String)")
        }
    }
    
    fileprivate func setupCollectionView(){
        infoCollectionView.dataSource = self
        infoCollectionView.delegate = self
        
        infoCollectionView.register(UserInfoViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .backgroundColor
        
        view.addSubviews(avator, saperator, infoCollectionView, signOutBtn)
        
        avator.anchors(centerX: view.centerXAnchor,
                       top: view.safeAreaLayoutGuide.topAnchor,
                       topConstant: view.bounds.height * 0.2,
                       widthValue: 100,
                       heightValue: 100)
        
        saperator.anchors(centerX: view.centerXAnchor,
                          top: avator.bottomAnchor,
                          topConstant: 24,
                          width: view.widthAnchor,
                          widthValue: 0.65,
                          heightValue: 2)
        
        infoCollectionView.anchors(centerX: view.centerXAnchor,
                                   top: saperator.bottomAnchor,
                                   topConstant: 24,
                                   width: view.widthAnchor,
                                   widthValue: 1,
                                   heightValue: view.bounds.height * 0.35)
        
        signOutBtn.anchors(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           width: view.widthAnchor,
                           widthValue: 1,
                           heightValue: 45)
    }
}

extension UserInfoViewController{
    @objc
    fileprivate func handleSignOutBtn(){
        print("sign out btn pressed!")
        do{
            try Auth.auth().signOut()
            self.view.window?.rootViewController = LoginViewController()
            self.view.window?.makeKeyAndVisible()
        }catch{
            print("sign out failed")
        }
    }
    
    fileprivate func fetchTheUserInfo(){
        if let uid = Auth.auth().currentUser?.uid{
            ref = ref.child("Users").child(uid)
            
            ref.observe(.value) { (snapshot) in
                if !snapshot.exists() { return }
                
                if let value = snapshot.value as? NSDictionary{
                    self.user?.name = value["name"] as! String
                    self.user?.email = value["email"] as! String
                }
            }
        }
    }
}

// MARK: - UICollectionView data source
extension UserInfoViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserInfoViewCell
        cell.backgroundColor = .systemYellow
        cell.name.text = user!.name
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout{
extension UserInfoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

//
//  TodayViewController.swift
//  Vital Days
//
//  Created by Junyu Lin on 11/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import NotificationCenter
import Firebase

class TodayViewController: UIViewController {
        
    let cellId = "cellId"
    var events = [Event]()
    let countdownCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .backgroundColor
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    fileprivate func setupViews(){
        // add collection view
        view.addSubviews(countdownCollectionView)
        
        countdownCollectionView.anchors(centerX: view.centerXAnchor,
                                        centerY: view.centerYAnchor,
                                        top: view.topAnchor,
                                        topConstant: 8,
                                        bottom: view.bottomAnchor,
                                        bottomConstant: 8,
                                        left: view.leftAnchor,
                                        leftConstant: 8,
                                        right: view.rightAnchor,
                                        rightConstant: 8)
        
        FirebaseApp.configure()
        
        // get the signed in user's uid
        let defaults = UserDefaults(suiteName: "group.sharingForVitalDaysWidgetExt")
        if let uid = defaults?.string(forKey: "uid"){
            let ref = Database.database().reference().child("Events").child(uid)
            ref.observe(.value) { (snapshot) in
                if !snapshot.exists() { return }
                print(snapshot)
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let value = snapshot.value as? NSDictionary{
                        self.events.append(Event(note: value["note"] as! String,
                                             noteType: value["noteType"] as! String,
                                             targetDate: value["targetDate"] as! String,
                                             leftDays: value["leftDays"] as! Int))
                    }
                }
                
                // refresh the data in the collectionView
                self.countdownCollectionView.reloadData()
            }
        }else{
            print("there is no uid found")
        }
        
        print("completed")
        
        
        // set the widget to be expandable
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        // set up the collectionview
        countdownCollectionView.backgroundColor = .backgroundColor
        countdownCollectionView.clipsToBounds = true
        countdownCollectionView.layer.cornerRadius = 5
        countdownCollectionView.dataSource = self
        countdownCollectionView.delegate = self
        countdownCollectionView.register(EventViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

// MARK: - UICollectionView data source
extension TodayViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventViewCell
        cell.backgroundColor = .cardViewColor
        cell.event = events[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TodayViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

// MARK: - NCWidgetProviding delegate
extension TodayViewController: NCWidgetProviding{
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact{
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded{
            self.preferredContentSize = CGSize(width: maxSize.width, height: CGFloat(70 * events.count))
        }
    }
}

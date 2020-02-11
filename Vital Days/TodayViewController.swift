//
//  TodayViewController.swift
//  Vital Days
//
//  Created by Junyu Lin on 11/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
        
    let cellId = "cellId"
    @IBOutlet weak var countdownCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    fileprivate func setupViews(){
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .cardViewColor
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
            self.preferredContentSize = CGSize(width: maxSize.width, height: 250)
        }
    }
}

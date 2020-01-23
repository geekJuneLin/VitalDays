//
//  DayCountDownCollectionViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class DayCountdownCollectionViewController: UICollectionViewController{
    
    let cellId = "cellId"
    
    let leftButton: UIBarButtonItem = {
        let img = UIImage(named: "menu")
        let btn = UIBarButtonItem()
        btn.image = img
        btn.tintColor = .white
        return btn
    }()
    
    let titleBar: UIBarButtonItem = {
        let label = UILabel()
        label.text = "Those Days"
        label.textColor = .white
        label.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .bold)
        let bar = UIBarButtonItem(customView: label)
        return bar
    }()
    
    let rightButton: UIBarButtonItem = {
        let img = UIImage(named: "plus")
        let btn = UIBarButtonItem()
        btn.image = img
        btn.tintColor = .white
        return btn
    }()
    
    let v = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        setupSlideMenuView()
    }
    
    
}


// MARK: - other functions
extension DayCountdownCollectionViewController{
    fileprivate func setupView(){
        collectionView.backgroundColor = .backgroundColor
        
        // set up data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // collectionView register cell or header or footer
        collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: cellId)
        
        // setup navBar left button
        leftButton.target = self
        leftButton.action = #selector(handleLeftButtonClick)
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [leftButton, titleBar]
        
        // setup navBar right button
        rightButton.target = self
        rightButton.action = #selector(handRightButtonClick)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    fileprivate func setupSlideMenuView(){
    }
}

// MARK: - objc functions
extension DayCountdownCollectionViewController{
    
    @objc
    fileprivate func handleLeftButtonClick(){
        print("left button clicked!")
        UIView.animate(withDuration: 0.5) {
            self.v.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc
    fileprivate func handRightButtonClick(){
        print("right button clicked!")
    }
}

// MARK: - UICollectionView data source
extension DayCountdownCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DayCountdownCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.85, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

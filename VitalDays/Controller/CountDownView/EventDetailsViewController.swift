//
//  EventDetailsViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class EventDetailsViewController: UICollectionViewController{
    
    let cellId = "cellId"
    
    var selectedIndex: IndexPath?
    
    var events: [Event]? 
    
    let eventView: EventDetailsView = {
        let view = EventDetailsView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightBtn: UIBarButtonItem = {
        let img = UIImage(named: "edit")
        let btn = UIBarButtonItem()
        btn.image = img
        btn.tintColor = .white
        return btn
    }()
    
    let leftBtn: UIBarButtonItem = {
        let img = UIImage(named: "back")
        let btn = UIBarButtonItem()
        btn.image = img
        btn.tintColor = .white
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // display the selected event
        collectionView.selectItem(at: selectedIndex, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
    }
    
    fileprivate func setupViews(){
        collectionView.backgroundColor = .backgroundColor
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(EventDetailsViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupNavigationBar(){
        // set translucent background
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        rightBtn.target = self
        rightBtn.action = #selector(handleRightBtn)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBtn
        
        leftBtn.target = self
        leftBtn.action = #selector(handleLeftBtn)
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftBtn
        
        navigationController?.navigationBar.topItem?.title = "Vital Days"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white,
                                                                   .font:UIFont.boldSystemFont(ofSize: 20)]
    }
}

// MARK: - other functions
extension EventDetailsViewController{
    @objc
    fileprivate func handleRightBtn(){
        print("edit btn pressed!")
    }
    
    @objc
    fileprivate func handleLeftBtn(){
        print("go back btn pressed!")
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionView data source
extension EventDetailsViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventDetailsViewCell
        cell.event = events![indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EventDetailsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.9, height: collectionView.bounds.height * 0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width * 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.bounds.width * 0.05, bottom: 0, right: collectionView.bounds.width * 0.05)
    }
}

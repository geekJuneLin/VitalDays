//
//  DayCountDownCollectionViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import Firebase

class DayCountdownCollectionViewController: UICollectionViewController{
    
    let cellId = "cellId"
    var countdownEvents = [Event]()
    
    var slideMenuVC: SlideMenuViewController!
    var isMenuViewDisplayed = false
    var showSlideMenuDelegate: ShowSlideMenuDelegate?
    
    // firebase
    var ref = Database.database().reference()
    
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
    
    let noCountdownEventImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "write-notes")?.withRenderingMode(.alwaysTemplate))
        img.tintColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let noCountdownEventLbl: UILabel = {
       let label = UILabel()
        label.text = "Create your Vital Days"
        label.textColor = .white
        label.font = UIFont.init(name: "Courier", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var edgePanGesture: UIScreenEdgePanGestureRecognizer?
    private var swipeGesture: UISwipeGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addObserverForRetrievingData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNoEventsViews()
        setupNavigationBar()
        setupGestures()
    }
}


// MARK: - other functions
extension DayCountdownCollectionViewController{

    fileprivate func setupView(){
        collectionView.backgroundColor = .backgroundColor
        
        // set up data source and delegate
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
    
    fileprivate func setupNoEventsViews(){
        collectionView.addSubviews(noCountdownEventImg, noCountdownEventLbl)
        
        noCountdownEventImg.anchors(centerX: collectionView.centerXAnchor,
                                    top: collectionView.topAnchor,
                                    topConstant: collectionView.bounds.height * 0.15)
        
        noCountdownEventLbl.anchors(centerX: collectionView.centerXAnchor,
                                    top: noCountdownEventImg.bottomAnchor,
                                    topConstant: 24)
    }
    
    fileprivate func setupNavigationBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    fileprivate func setupGestures(){
        // add gestures
        edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePanGesture))
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        edgePanGesture!.edges = .left
        swipeGesture?.direction = .left
        swipeGesture!.isEnabled = false
        collectionView.addGestureRecognizer(edgePanGesture!)
        collectionView.addGestureRecognizer(swipeGesture!)
    }
    
    /// show or hide the slide menu view
    /// and change the enability of edgePanGesture and swipGesture according to the visibility of the slide menu view
    fileprivate func showOrHideSlideMenu(){
        showSlideMenuDelegate?.showSlideMenu(isDisplayed: isMenuViewDisplayed)
        isMenuViewDisplayed.toggle()
        edgePanGesture!.isEnabled = !isMenuViewDisplayed
        swipeGesture!.isEnabled = isMenuViewDisplayed
    }
    
    /// add observer to retrieve data from firebase
    fileprivate func addObserverForRetrievingData(){
//        if let userEmail = Auth.auth().currentUser?.email{
//            print("current user: \(userEmail)")
//            ref = ref.child(userEmail)
//            
//            ref.observe(.value) { (snapshot) in
//                if !snapshot.exists() { return }
//                print(snapshot)
//                
//                if snapshot.childrenCount > 0{
//                    self.noCountdownEventImg.isHidden = true
//                    self.noCountdownEventLbl.isHidden = true
//                }
//                
//                if self.countdownEvents.count > 0{
//                    self.countdownEvents.removeAll()
//                }
//                
//                for child in snapshot.children{
//                    if let snapshot = child as? DataSnapshot,
//                        let value = snapshot.value as? NSDictionary{
//                        self.countdownEvents.append(Event(note: value["note"] as? String ?? "",
//                                                     noteType: value["noteType"] as? String ?? "",
//                                                     targetDate: value["targetDate"] as? String ?? "",
//                                                     leftDays: value["leftDays"] as? Int ?? 0))
//                    }
//                }
//                
//                self.collectionView.reloadData()
//            }
//        }
    }
}

// MARK: - objc functions
extension DayCountdownCollectionViewController{
    
    /// display or hide the slide menu view
    @objc
    fileprivate func handleLeftButtonClick(){
        print("left button clicked!")
        showOrHideSlideMenu()
    }
    
    /// display the create countdown view controller
    @objc
    fileprivate func handRightButtonClick(){
        print("right button clicked!")
        let createVC = CreateDayViewController(collectionViewLayout: UICollectionViewFlowLayout())
        createVC.saveVitalDayDelegate = self
        let navigationVC = UINavigationController(rootViewController: createVC)
        navigationVC.modalPresentationStyle = .custom
        navigationVC.transitioningDelegate = self
        present(navigationVC, animated: true, completion: nil)
    }
    
    /// using edge pan gesture to display the slide menu
    @objc
    fileprivate func handleEdgePanGesture(_ reconizer: UIScreenEdgePanGestureRecognizer){
        if reconizer.state == .recognized{
            print("detected the gesture")
            showOrHideSlideMenu()
        }
    }
    
    /// using swipegesture (with left direction) to hide the slide menu
    @objc
    fileprivate func handleSwipeGesture(_ reconizer: UISwipeGestureRecognizer){
        print("triggered!")
        if reconizer.direction == .left{
            showOrHideSlideMenu()
        }
    }
}

// MARK: - UICollectionView data source
extension DayCountdownCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countdownEvents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardViewCell
        cell.event = countdownEvents[indexPath.item]
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 36, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - customized presentation animation
extension DayCountdownCollectionViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
}

// MARK: - save vital days event delegate
extension DayCountdownCollectionViewController: SaveVitalDayDelegate{
    func saveVitalDay(event: Event) {
        print("save the event \(event)")
        noCountdownEventImg.isHidden = true
        noCountdownEventLbl.isHidden = true
        countdownEvents.append(event)
        collectionView.reloadData()
    }
}

//
//  ViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 22/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    let homeTabItem: UITabBarItem = {
       let bar = UITabBarItem()
        bar.title = "Home"
        let img = UIImage(named: "home")
        img?.withTintColor(.cardViewColor, renderingMode: .alwaysTemplate)
        bar.image = img
        return bar
    }()
    
    let shareTabItem: UITabBarItem = {
        let bar = UITabBarItem()
        bar.title = "Share"
        let img = UIImage(named: "share")
        img?.withTintColor(.cardViewColor, renderingMode: .alwaysTemplate)
        bar.image = img
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTabVC()
    }
    
    fileprivate func setupView(){
        tabBar.barTintColor = UIColor.white
        tabBar.alpha = 0.35
    }
    
    fileprivate func setupTabVC(){
        let homeVC = UINavigationController(rootViewController:
            DayCountdownCollectionViewController(collectionViewLayout:
                UICollectionViewFlowLayout()))
        homeVC.tabBarItem = homeTabItem
        
        let shareVC = UINavigationController(rootViewController:
        UIViewController())
        shareVC.view.backgroundColor = .cyan
        shareVC.tabBarItem = shareTabItem
        
        viewControllers = [homeVC, shareVC]
    }
}


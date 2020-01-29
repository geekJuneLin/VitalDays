//
//  ContainerViewController.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController{
    
    var slideMenuVC: SlideMenuViewController!
    var tabbarController: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
    
    fileprivate func setupTabBarController(){
        tabbarController = MainViewController()
        
        // setup the shadow of the tabBarController
        tabbarController.view.layer.masksToBounds = false
        tabbarController.view.layer.shadowPath = UIBezierPath(rect: tabbarController.view.bounds).cgPath
        tabbarController.view.layer.shadowColor = UIColor.darkGray.cgColor
        tabbarController.view.layer.shadowOffset = .zero
        tabbarController.view.layer.shadowRadius = 5
        
        // setup the showSlideMenuDelegate
        tabbarController.showSlideMenuDelegate = self
        
        // add the tabBarController into the container's subview
        view.insertSubview(tabbarController.view, at: 0)
        addChild(tabbarController)
        tabbarController.didMove(toParent: self)
    }
    
    func configureSlideMenu(){
        if slideMenuVC == nil{
            slideMenuVC = SlideMenuViewController()
            view.insertSubview(slideMenuVC.view, at: 0)
            addChild(slideMenuVC)
            slideMenuVC.didMove(toParent: self)
            print("added slide menu view")
        }
    }
    
    func showSlideMenu(displayed: Bool){
        
        if displayed{
            UIView.animate(withDuration: 0.5) {
                self.tabbarController.view.transform = CGAffineTransform(translationX: 150, y: 0)
                self.tabbarController.view.layer.shadowOpacity = 0.8
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.tabbarController.view.transform = CGAffineTransform(translationX: 0, y: 0)
                self.tabbarController.view.layer.shadowOpacity = 0
            }
        }
    }
}

// MARK: - show the slide menu view
extension ContainerViewController: ShowSlideMenuDelegate{
    func showSlideMenu(isDisplayed: Bool) {
        if !isDisplayed{
            configureSlideMenu()
        }
        
        showSlideMenu(displayed: !isDisplayed)
    }
}

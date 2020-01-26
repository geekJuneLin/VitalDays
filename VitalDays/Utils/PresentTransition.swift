//
//  File.swift
//  VitalDays
//
//  Created by Junyu Lin on 26/01/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit

class PresentTransition: NSObject{
    
}

extension PresentTransition: UIViewControllerAnimatedTransitioning{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else{return}
        
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        
        toVC.view.frame = CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height)
        toVC.view.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width,
                                                y: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            toVC.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (complete) in
            UIApplication.shared.currentKeyWindow.addSubview(toVC.view)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

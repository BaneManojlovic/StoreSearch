//
//  BounceAnimationController.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 03/08/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//
import UIKit

class BounceAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    // This determines how long the animation is. In this case is 0.4 sec
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    // This performs the actual animation.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toViewController = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            let containerView = transitionContext.containerView
            
            toView.frame = transitionContext.finalFrame(for: toViewController)
            
            containerView.addSubview(toView)
            
            toView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            // Important method are transitionDuration()
            UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                    delay: 0,
                                    options: .calculationModeCubic,
                                    animations: {
                                        UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                           relativeDuration: 0.334,
                                                           animations: {
                                                            toView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.334,
                                                           relativeDuration: 0.333,
                                                           animations: {
                                                            toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 0.666,
                                                           relativeDuration: 0.333,
                                                           animations: {
                                                            toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                        })
            },
                                    completion: { finished in
                                        transitionContext.completeTransition(finished)
            })
            
            
        }
        
    }
    
    
}

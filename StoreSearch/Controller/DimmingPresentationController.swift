//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 02/08/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    
    // MARK: - Lazy Properties
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    
    // MARK: - Overriden Properties
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    // MARK: - Overriden Methods
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
        
        // Animating background gradient view
        dimmingView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
}


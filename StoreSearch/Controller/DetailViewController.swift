//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 02/08/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    // MARK: - Action Methods
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Conforming to UIViewControllerTransitioningDelegate
extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

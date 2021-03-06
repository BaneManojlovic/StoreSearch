//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Bane Manojlovic on 02/08/2020.
//  Copyright © 2020 Bane Manojlovic. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {
    
    // MARK: - Enums
    enum AnimationStyle {
        case slide
        case fade
    }
    
    // MARK: - Outlets
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    // MARK: - Properties
    var downloadTask: URLSessionDownloadTask?
    var dismissStyle = AnimationStyle.fade
    var isPopUp = false
    
    // MARK: - Computed Properties
    var searchResult: SearchResult! {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTargets()

        if searchResult != nil {
            updateUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    deinit {
        print("deinit \(self)")
        downloadTask?.cancel()
    }
    
    // MARK: - Overriden methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMenu" {
            let controller = segue.destination as! MenuViewController
            controller.delegate = self
        }
    }
    
    // MARK: - Setup Methods
    func setupUI() {
        view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        view.backgroundColor = UIColor.clear
        popupView.layer.cornerRadius = 10
    }
    
    func setupTargets() {
        if isPopUp {
            let gestureReckognizer = UITapGestureRecognizer(target: self, action: #selector(close))
            gestureReckognizer.cancelsTouchesInView = false
            gestureReckognizer.delegate = self
            view.addGestureRecognizer(gestureReckognizer)
            view.backgroundColor = UIColor.clear
        } else {
            view.backgroundColor = UIColor(patternImage: UIImage(named: "LandscapeBackground")!)
            popupView.isHidden = true
            title = "Store Search"
        }
        
    }
    
    // MARK: - Action Methods
    @IBAction func close() {
        dismissStyle = .slide
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openInStore() {
        if let url = URL(string: searchResult.storeURL) {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: nil)
        }
    }
    
    // MARK: - Helper Methods
    func updateUI() {
        nameLabel.text = searchResult.name
        
        if searchResult.artist.isEmpty {
            artistNameLabel.text = "Unknown"
        } else {
            artistNameLabel.text = searchResult.artist
        }
        
        kindLabel.text = searchResult.type
        genreLabel.text = searchResult.genre
        
        // For showing price on button
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        let priceText: String
        
        if searchResult.price == 0 {
            priceText = "Free"
        } else if let text = formatter.string(from: searchResult.price as NSNumber) {
            priceText = text
        } else {
            priceText = ""
        }
        priceButton.setTitle(priceText, for: .normal)
        
        // For getting image
        if let largeImage = URL(string: searchResult.imageLarge) {
            downloadTask = artworkImageView.loadImage(url: largeImage)
        }
        
        popupView.isHidden = false
    }
    
}

// MARK: - Conforming to UIViewControllerTransitioningDelegate
extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // For bouncing animation
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissStyle {
        case .slide:
            return SlideOutAnimationController()
        case .fade:
            return FadeOutAnimationController()
        }
    }

}

// MARK: - Conforming to UIGestureReckognizerDelegate
extension DetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}

// MARK: - Conforming to MenuViewControllerDelegate
extension DetailViewController: MenuViewControllerDelegate {
    
    func menuViewControllerSendEmail(_ controller: MenuViewController) {
        dismiss(animated: true) {
            if MFMailComposeViewController.canSendMail() {
                let controller = MFMailComposeViewController()
                controller.mailComposeDelegate = self
                controller.modalPresentationStyle = .formSheet
                controller.setSubject("Support Request")
                controller.setToRecipients(["bane1manojlvic@gmail.com"])
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Conforming to MFMailComposeViewControllerDelegate
extension DetailViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

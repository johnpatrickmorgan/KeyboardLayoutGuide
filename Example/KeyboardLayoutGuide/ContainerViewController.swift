//
//  ContainerViewController.swift
//  KeyboardLayoutGuide
//
//  Created by John Morgan on 09/05/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerXConstraint: NSLayoutConstraint!
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        if let view = sender.view, sender.state == .changed {
            
            let translation = sender.translation(in: view)
            
            centerXConstraint.constant += translation.x
            centerYConstraint.constant += translation.y

            sender.setTranslation(.zero, in: view)
        }
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let alertVC = UIAlertController(
            title: "ALERT",
            message: "This is an alert",
            preferredStyle: .alert
        )
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

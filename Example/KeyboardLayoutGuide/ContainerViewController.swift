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
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        
        if let view = sender.view where sender.state == .Changed {
            
            let translation = sender.translationInView(view)
            
            centerXConstraint.constant += translation.x
            centerYConstraint.constant += translation.y

            sender.setTranslation(CGPointZero, inView: view)
        }
    }
}

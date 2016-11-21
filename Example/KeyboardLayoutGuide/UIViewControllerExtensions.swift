//
//  UIViewControllerExtensions.swift
//  KeyboardLayoutGuide
//
//  Created by John Morgan on 25/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @IBAction func dismissKeyboard(_ sender: AnyObject?) {
        
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    @IBAction func dismissIfPresented(_ sender: AnyObject?) {
        
        dismissIfPresented()
    }
    
    func dismissIfPresented(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        
        presentingViewController?.dismiss(animated: animated, completion: completion)
    }
}

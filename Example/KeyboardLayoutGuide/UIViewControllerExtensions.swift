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
    
    @IBAction func dismissKeyboard(sender: AnyObject?) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    
    @IBAction func dismissIfPresented(sender: AnyObject?) {
        
        dismissIfPresented()
    }
    
    func dismissIfPresented(animated: Bool = true, completion: (() -> Void)? = nil) {
        
        presentingViewController?.dismissViewControllerAnimated(animated, completion: completion)
    }
}

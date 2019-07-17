//
//  UIViewController+KeyboardLayoutGuide.swift
//  Pods
//
//  Created by John Morgan on 25/04/2016.
//
//

import Foundation
import LifecycleHooks

public extension UIViewController {
    
    var viewIfViewIsLoaded: UIView? {
        
        if #available(iOS 9.0, *) {
            return viewIfLoaded
        }
        return isViewLoaded ? view : nil
    }
    
    fileprivate struct AssociatedKeys {
        
        static var keyboardProxy = "KeyboardLayoutGuide_keyboardProxy"
    }
    
    /**
     Provide a UIView from a storyboard/NIB to act as a proxy for the keyboard layout guide. The proxy 
     must be part of the view controller's view hierarchy. When it moves to a window, its edges will be
     constrained to match those of the keyboard layout guide. When the view will disappear, the constraints 
     will be deactivated.
     */
    @IBOutlet var klg_keyboardProxy: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.keyboardProxy) as? UIView
        }
        set {
            if let proxy = newValue {
                klg_constrainKeyboardProxy(proxy)
            }
            objc_setAssociatedObject(self, &AssociatedKeys.keyboardProxy, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /**
     Create custom constraints using the keyboard layout guide. Constraints are added when the view is
     added to a window, and removed when the view will disappear.
     
     - parameter createConstraints: A closure within which the layout guide is available for use in constraints. Generated constraints should be returned by the closure.
     */
    func klg_constrainKeyboard(_ createConstraints: @escaping (KeyboardLayoutGuide) -> [NSLayoutConstraint]) {
        
        onView(.didMoveToWindow) { [weak self] in
            
            if let window = self?.viewIfViewIsLoaded?.window {
                
                let guide = KeyboardLayoutGuideManager.keyboardLayoutGuide(forWindow: window)
                let constraints = createConstraints(guide)
                constraints.forEach { $0.isActive = true }
                
                self?.on(.viewWillDisappear, onceOnly: true) { _ in
                    
                    constraints.forEach { $0.isActive = false }
                }
            }
        }
    }
    
    /**
     Provide a UIView to act as a proxy for the keyboard layout guide. The proxy must be part of the view
     controller's view hierarchy. When it moves to a window, its edges will be constrained to match those
     of the keyboard layout guide. When the view will disappear, the constraints will be deactivated.
     
     - parameter proxy: A UIView instance whose edges will be constrained to match those of the keyboard
     layout guide. It should not have any other constraints that might conflict . The proxy must be part
     of the view controller's view hierarchy.
     */
    func klg_constrainKeyboardProxy(_ proxy: UIView) {
        
        proxy.isHidden = true
        
        klg_constrainKeyboard() { keyboardLayoutGuide in
            
            let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
            var constraints = [NSLayoutConstraint]()
            
            for attribute in attributes {
                
                let constraint = NSLayoutConstraint(
                    item: keyboardLayoutGuide,
                    attribute: attribute,
                    relatedBy: .equal,
                    toItem: proxy,
                    attribute: attribute,
                    multiplier: 1.0,
                    constant: 0.0)
                
                constraint.isActive = true
                constraint.identifier = "KeyboardLayoutGuideProxy_\(attribute)"
                constraints.append(constraint)
            }
            
            return constraints
        }
    }
}

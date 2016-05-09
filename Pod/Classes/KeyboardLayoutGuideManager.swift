//
//  KeyboardProxyManager.swift
//  Pods
//
//  Created by John Morgan on 10/03/2016.
//
//

import Foundation

/**
 *  Keeps track of the keyboard height and a keyboard layout guide for any windows that require one.
 */
public struct KeyboardLayoutGuideManager {
    
    private static var keyboardLayoutGuides = [UIWindow : KeyboardLayoutGuide]()
    
    /// The current height of the keyboard.
    public private(set) static var keyboardHeight: CGFloat = 0.0 {
        didSet {
            updateGuides()
        }
    }
    
    static func registerForNotificationsIfNeeded() {
        
        var token: dispatch_once_t = 0
        dispatch_once(&token) { () -> Void in
            NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: .mainQueue()) { notification in
                
                guard let
                    newFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(),
                    duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else {
                    return
                }
                
                keyboardDidChangeFrame(newFrame, duration: duration)
            }
        }
    }
    
    static func keyboardLayoutGuide(forWindow window: UIWindow) -> KeyboardLayoutGuide {
        
        registerForNotificationsIfNeeded()
        
        if let guide = keyboardLayoutGuides[window] { return guide }
        
        let guide = KeyboardLayoutGuide()
        
        window.addSubview(guide)
        
        let edges: [NSLayoutAttribute] = [.Bottom, .Leading, .Trailing]
        
        for edge in edges {
            NSLayoutConstraint(item: window,
                               attribute: edge,
                               relatedBy: .Equal,
                               toItem: guide,
                               attribute: edge,
                               multiplier: 1.0,
                               constant: 0.0).active = true
        }

        guide.keyboardHeight = keyboardHeight
        
        keyboardLayoutGuides[window] = guide
        
        return guide
    }
    
    static func updateGuides() {
        
        for (_, guide) in keyboardLayoutGuides {
            guide.keyboardHeight = keyboardHeight
        }
    }
    
    static func keyboardDidChangeFrame(newFrame: CGRect, duration: NSTimeInterval) {
        
        guard let window = UIApplication.sharedApplication().keyWindow else { return }
        
        let visibleKeyboardFrame = CGRectIntersection(newFrame, window.frame)
        
        window.layoutIfNeeded()
        UIView.animateWithDuration(duration) {
            
            keyboardHeight = visibleKeyboardFrame.height
            window.layoutIfNeeded()
        }
    }
}
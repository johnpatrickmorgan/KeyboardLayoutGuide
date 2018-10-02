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
    
    private static var __registerForNotificationsOnceOnly: () = { () -> Void in
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { notification in
            
            guard let
                newFrame = ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                let duration = (notification as NSNotification).userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return
            }
            
            keyboardDidChangeFrame(newFrame, duration: duration)
        }
    }()
    
    private static var keyboardLayoutGuides = [UIWindow : KeyboardLayoutGuide]()
    
    /// The current height of the keyboard.
    public fileprivate(set) static var keyboardHeight: CGFloat = 0.0 {
        didSet {
            updateGuides()
        }
    }
    
    static func keyboardLayoutGuide(forWindow window: UIWindow) -> KeyboardLayoutGuide {
        
        _ = self.__registerForNotificationsOnceOnly
        
        if let guide = keyboardLayoutGuides[window] { return guide }
        
        let guide = KeyboardLayoutGuide()
        
        window.addSubview(guide)
        
        let edges: [NSLayoutConstraint.Attribute] = [.bottom, .leading, .trailing]
        
        for edge in edges {
            NSLayoutConstraint(item: window,
                               attribute: edge,
                               relatedBy: .equal,
                               toItem: guide,
                               attribute: edge,
                               multiplier: 1.0,
                               constant: 0.0).isActive = true
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
    
    static func keyboardDidChangeFrame(_ newFrame: CGRect, duration: TimeInterval) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let visibleKeyboardFrame = newFrame.intersection(window.frame)
        
        window.layoutIfNeeded()
        UIView.animate(withDuration: duration) {
            
            keyboardHeight = visibleKeyboardFrame.height
            window.layoutIfNeeded()
        }
    }
}

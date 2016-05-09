//
//  KeyboardLayoutGuide.swift
//  Pods
//
//  Created by John Morgan on 10/03/2016.
//
//

import UIKit

/** 
 *  A UIView subclass created and laid out by the KeyboardLayoutGuideManager to match the keyboard's layout.
 */
public class KeyboardLayoutGuide: UIView {

    var keyboardHeight: CGFloat = 0.0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        sharedInit()
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        sharedInit()
    }
    
    func sharedInit() {
        
        setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
        setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        hidden = true
        userInteractionEnabled = false
        alpha = 0.0
    }
    
    override public func intrinsicContentSize() -> CGSize {
        
        return CGSize(width: UIViewNoIntrinsicMetric, height: keyboardHeight)
    }
}

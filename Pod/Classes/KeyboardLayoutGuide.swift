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

    public var keyboardHeight: CGFloat = 0.0 {
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
        
        setContentHuggingPriority(UILayoutPriority.required, for: .vertical)
        setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        isHidden = true
        isUserInteractionEnabled = false
        alpha = 0.0
    }
    
    override public var intrinsicContentSize: CGSize {
        
        return CGSize(width: UIViewNoIntrinsicMetric, height: keyboardHeight)
    }
}

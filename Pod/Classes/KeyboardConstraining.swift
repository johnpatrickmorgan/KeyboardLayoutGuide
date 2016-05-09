//
//  KeyboardLayoutGuidedMixin.swift
//  Pods
//
//  Created by John Morgan on 04/05/2016.
//
//

import Foundation

/**
 *  Mixin to enable keyboard layout guide methods to be used with unprefixed method names.
 */
public protocol KeyboardConstraining { }

extension KeyboardConstraining where Self: UIViewController {
    
    /**
     Create custom constraints using the keyboard layout guide. Constraints are added when the view is
     added to a window, and removed when the view will disappear.
     
     - parameter createConstraints: A closure within which the layout guide is available for use in constraints. Generated constraints should be returned by the closure.
     */
    public func constrainKeyboard(createConstraints: KeyboardLayoutGuide -> [NSLayoutConstraint]) {
        
        klg_constrainKeyboard(createConstraints)
    }
    
    /**
     Create custom constraints using the keyboard layout guide. Constraints are added when the view is
     added to a window, and removed when the view will disappear.
     
     - parameter view1: A view to be passed into the closure
     - parameter createConstraints: A closure within which the layout guide is available for use in constraints. Generated constraints should be returned by the closure.
     */
    public func constrainKeyboard<T: UIView>(view1: T, createConstraints: (KeyboardLayoutGuide, T) -> [NSLayoutConstraint]) {
        
        klg_constrainKeyboard() { [weak view1] keyboard in
            
            guard let view1 = view1 else { return [] }
            return createConstraints(keyboard, view1)
        }
    }
    
    /**
     Create custom constraints using the keyboard layout guide. Constraints are added when the view is
     added to a window, and removed when the view will disappear.
     
     - parameter view1: A view to be passed into the closure
     - parameter view2: A view to be passed into the closure
     - parameter createConstraints: A closure within which the layout guide is available for use in constraints. Generated constraints should be returned by the closure.
     */
    public func constrainKeyboard<T: UIView, U: UIView>(view1: T, _ view2: U, createConstraints: (KeyboardLayoutGuide, T, U) -> [NSLayoutConstraint]) {
        
        klg_constrainKeyboard() { [weak view1, weak view2] keyboard in
            
            guard let view1 = view1, view2 = view2 else { return [] }
            return createConstraints(keyboard, view1, view2)
        }
    }
    
    /**
     Create custom constraints using the keyboard layout guide. Constraints are added when the view is
     added to a window, and removed when the view will disappear.
     
     - parameter view1: A view to be passed into the closure
     - parameter view2: A view to be passed into the closure
     - parameter view3: A view to be passed into the closure
     - parameter createConstraints: A closure within which the layout guide is available for use in constraints. Generated constraints should be returned by the closure.
     */
    public func constrainKeyboard<T: UIView, U: UIView, V: UIView>(view1: T, _ view2: U, _ view3: V, createConstraints: (KeyboardLayoutGuide, T, U, V) -> [NSLayoutConstraint]) {
        
        klg_constrainKeyboard() { [weak view1, weak view2, weak view3] keyboard in
            
            guard let view1 = view1, view2 = view2, view3 = view3 else { return [] }
            return createConstraints(keyboard, view1, view2, view3)
        }
    }
    
    /**
     Create custom constraints using the keyboard layout guide. Constraints are added when the view is
     added to a window, and removed when the view will disappear.
     
     - parameter view1: A view to be passed into the closure
     - parameter view2: A view to be passed into the closure
     - parameter view3: A view to be passed into the closure
     - parameter view4: A view to be passed into the closure
     - parameter createConstraints: A closure within which the layout guide is available for use in constraints. Generated constraints should be returned by the closure.
     */
    public func constrainKeyboard<T: UIView, U: UIView, V: UIView, W: UIView>(view1: T, _ view2: U, _ view3: V, _ view4: W, createConstraints: (KeyboardLayoutGuide, T, U, V, W) -> [NSLayoutConstraint]) {
        
        klg_constrainKeyboard() { [weak view1, weak view2, weak view3, weak view4] keyboard in
            
            guard let view1 = view1, view2 = view2, view3 = view3, view4 = view4 else { return [] }
            return createConstraints(keyboard, view1, view2, view3, view4)
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
    public func constrainKeyboardProxy(proxy: UIView) {
        
        klg_constrainKeyboardProxy(proxy)
    }
}

⌨️ KeyboardLayoutGuide ⌨️
==========================

[![Version](https://img.shields.io/cocoapods/v/KeyboardLayoutGuide.svg?style=flat)](http://cocoapods.org/pods/KeyboardLayoutGuide)
[![License](https://img.shields.io/cocoapods/l/KeyboardLayoutGuide.svg?style=flat)](http://cocoapods.org/pods/KeyboardLayoutGuide)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)

Imagine being able to set up Auto Layout constraints directly between your views and the iOS keyboard, so that your layout updates whenever the keyboard's frame changes. KeyboardLayoutGuide makes that possible, providing options to do so entirely within Interface Builder, or in code via a simple interface:

    constrainKeyboard(myView) { keyboard, myView in
        
        // create and return your keyboard-based constraints
    }

Usage
-----

### Via code

Declare your view controller to conform to `KeyboardConstraining`. This is an empty protocol that makes a number of methods available, so that you can do something like:

    constrainKeyboard(contentView) { keyboard, contentView in
        
        return [keyboard.topAnchor.constraint(equalTo: contentView.bottomAnchor)]
    }

The bottom of `contentView` will now be constrained to the top of the keyboard, and will update whenever the keyboard's frame changes. You can use vanilla Auto Layout or any third-party library for creating the constraints. They will be activated when the view is added to a window, and deactivated on `viewWillDisappear`. 

For a more complex example, imagine a view where the bottom of the table view should rest on the top of the tab bar, or the top of the keyboard, whichever is higher. In that instance, you would constrain the bottom of your tableView to the top of the bottomLayoutGuide, with a priority lower than 1000 (since it needs to be broken when the keyboard appears). When coupled with an inequality constraint with the keyboard, this will ensure the correct behaviour:

    constrainKeyboard(tableView) { keyboard, tableView in
        
        return [keyboard.topAnchor.constraint(greaterThanOrEqualTo: tableView.bottomAnchor)]
    }

### Via Interface Builder

Simply add a new `UIView` to your view. This will be your keyboard proxy, so assign it to your view controller's `klg_keyboardProxy` property. At runtime, the keyboard proxy's frame will be constrained to match that of the keyboard, so you can add any constraints you wish between your other views and the keyboard proxy. 

Although constraints will be added at runtime, you still need to satisfy Interface Builder that the keyboard proxy has a valid layout. Add _leading_, _trailing_, _bottom_ and _height_ constraints between the proxy and its superview. These placeholder constraints will satisfy Interface Builder, but you should ensure they are removed at build time by checking `Placeholder ☑ Remove at build time` for each one in Interface Builder. You can preview how your layout changes when the keyboard appears by adjusting the _height_ constraint on your keyboard proxy.

## How does it work?

[LifecycleHooks](https://github.com/johnpatrickmorgan/LifecycleHooks) are used to add lifecycle-driven behaviour to your view controller. The keyboard layout guide is attached to the window itself, so its frame is not affected by changes in your view's frame. 


## Installation

### CocoaPods

KeyboardLayoutGuide is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KeyboardLayoutGuide"
```

### Carthage

Add the following to your Cartfile:

```
github "johnpatrickmorgan/KeyboardLayoutGuide"
```

## License

KeyboardLayoutGuide is available under the MIT license. See the LICENSE file for more info.

//
//  ViewController.swift
//  KeyboardLayoutGuide
//
//  Created by John Morgan on 03/10/2016.
//  Copyright (c) 2016 John Morgan. All rights reserved.
//

import UIKit
import KeyboardLayoutGuide

class ProgrammaticViewController: UIViewController, KeyboardConstraining {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        constrainKeyboard(contentView) { keyboard, contentView in
            
            return [keyboard.topAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor)]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let title = presentingViewController == nil ? "PRESENT" : "CLOSE"
        
        button.setTitle(title, for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        dismissKeyboard(nil)
    }
    
    @IBAction func presentButtonTapped(_ sender: AnyObject?) {
        
        if let presentingViewController = presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Test")
        vc.view.backgroundColor = .green
        
        present(vc, animated: true, completion: nil)
    }
}


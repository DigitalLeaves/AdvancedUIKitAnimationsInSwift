//
//  BasicAnimationViewController.swift
//  AdvancedUIKitAnimations
//
//  Created by Ignacio Nieto Carvajal on 11/7/17.
//  Copyright © 2017 Digital Leaves. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UIViewController {
    // outlets
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var animateButton: UIButton!
    
    // data
    var originalPosition: CGRect = .zero
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originalPosition = squareView.frame
    }
    
    @IBAction func triggerAnimation(_ sender: UIButton) {
        animateButton.isEnabled = false
        
        // calculate final position
        let finalPosition: CGRect
        if squareView.frame == originalPosition {
            finalPosition = originalPosition.offsetBy(dx: 0, dy: -(self.view.frame.height * kTopMarginSpan))
        } else {
            finalPosition = originalPosition
        }
        
        // animate change
        UIView.animate(withDuration: 1.0, animations: {
            self.squareView.frame = finalPosition
        }) { (success) in
            self.animateButton.isEnabled = true
        }
    }
}

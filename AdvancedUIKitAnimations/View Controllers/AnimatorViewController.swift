//
//  AnimatorViewController.swift
//  AdvancedUIKitAnimations
//
//  Created by Ignacio Nieto Carvajal on 11/7/17.
//  Copyright © 2017 Digital Leaves. All rights reserved.
//

import UIKit

class AnimatorViewController: UIViewController {
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
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
        animator.addAnimations {
            self.squareView.frame = finalPosition
        }
        animator.addCompletion { (position) in
            self.animateButton.isEnabled = true
        }
        animator.startAnimation()
    }
}

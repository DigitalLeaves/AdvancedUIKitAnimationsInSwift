//
//  InteractiveAnimationViewController.swift
//  AdvancedUIKitAnimations
//
//  Created by Ignacio Nieto Carvajal on 11/7/17.
//  Copyright © 2017 Digital Leaves. All rights reserved.
//

import UIKit

class InteractiveAnimationViewController: UIViewController {
    // outlets
    @IBOutlet weak var squareView: UIView!
    
    // data
    var originalPosition: CGRect = .zero
    var currentAnimation: UIViewPropertyAnimator!
    var currentProgress: CGFloat = 0
    var panRecognizer: UIPanGestureRecognizer!
    var tapRecognizer: UITapGestureRecognizer!
    var translationFactor: CGFloat = -1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // initialize gesture recognizers
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(InteractiveAnimationViewController.handlePan(recognizer:)))
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(InteractiveAnimationViewController.handleTap(recognizer:)))
        
        squareView.addGestureRecognizer(panRecognizer)
        squareView.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // save original position for square
        originalPosition = squareView.frame
    }
    
    // MARK: - Animation methods
    
    func startOrReverseAnimation() {
        if currentAnimation != nil {
            currentAnimation.isReversed = !currentAnimation.isReversed
            currentAnimation.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        } else {
            initializeAndStartCurrentAnimation()
            currentAnimation.pauseAnimation()
            currentProgress = currentAnimation.fractionComplete
        }
    }
    
    func initializeAndStartCurrentAnimation() {
        self.currentAnimation = UIViewPropertyAnimator(duration: 3.0, dampingRatio: 0.5, animations: {
            if self.squareView.frame == self.originalPosition {
                self.squareView.frame = self.originalPosition.offsetBy(dx: 0, dy: -(self.view.frame.height * kTopMarginSpan))
                self.translationFactor = -1
            } else {
                self.squareView.frame = self.originalPosition
                self.translationFactor = 1
            }
        })
    }
    
    // MARK: - handle gestures
    
    @objc func handleTap(recognizer: UITapGestureRecognizer!) {
        startOrReverseAnimation()
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer!) {
        switch recognizer.state {
        case .began:
            initializeAndStartCurrentAnimation()
            currentAnimation.pauseAnimation()
            currentProgress = currentAnimation.fractionComplete
        case .changed:
            let translation = recognizer.translation(in: squareView)
            currentAnimation.fractionComplete = ((self.translationFactor * translation.y / 100) * kTopMarginSpan) + currentProgress
        case .ended:
            let translation = recognizer.translation(in: squareView)
            currentAnimation.isReversed = fabs(translation.y / 100) < 0.5
            currentAnimation.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
}

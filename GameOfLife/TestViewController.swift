//
//  TestViewController.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 24/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    enum State {
        case closed, partiallyOpen, fullyOpen
    }
    var state: State = .closed
    
    @IBOutlet var constraint: NSLayoutConstraint!
    @IBOutlet var drawer: UIView! {
        didSet {
            drawer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panRecognised)))
        }
    }
    
    let params = UISpringTimingParameters(damping: 1, response: 0.5)
    lazy var openAnimator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        animator.addAnimations {
            self.constraint.constant = -500
            self.view.layoutIfNeeded()
        }
        animator.pausesOnCompletion = true
        return animator
    }()
    
    lazy var overOpenAnimator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        animator.addAnimations {
            self.constraint.constant = -600
            self.view.layoutIfNeeded()
        }
        animator.pausesOnCompletion = true
        return animator
    }()
    
    lazy var closeAnimatior: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        animator.addAnimations {
            self.constraint.constant = -100
            self.view.layoutIfNeeded()
        }
        animator.pausesOnCompletion = true
        return animator
    }()
    
    enum PanState {
        case opening, rubberbanding, closing
    }
    var panState = PanState.opening {
        didSet {
            print("panstate changed", panState)
        }
    }
    
    var rubberbandingTransModifier: CGFloat = 0
    
    @objc func panRecognised(_ recognizer: UIPanGestureRecognizer) {
        let trans = recognizer.translation(in: drawer).y
        let velocity = recognizer.velocity(in: drawer).y
        
        if recognizer.state == .began {
            switch state {
            case .partiallyOpen where velocity < 0: panState = .opening
            case .fullyOpen where velocity < 0: panState = .rubberbanding
            case .fullyOpen:
                panState = .closing
            default: break
            }
        }
        
        switch (recognizer.state, panState) {
        case (.changed, .opening):
            openAnimator.fractionComplete = -trans / 400
        case (.ended, .opening):
            openAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
            
        case (.changed, .rubberbanding):
            overOpenAnimator.fractionComplete = pow(-(trans + rubberbandingTransModifier), 0.7) / 100
        case (.ended, .rubberbanding):
            overOpenAnimator.isReversed = true
            overOpenAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
            
        case (.changed, .closing):
            openAnimator.isReversed = true
            openAnimator.fractionComplete = trans / 400
        case (.ended, .closing):
            openAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
        default: break
        }
    }
    
//    @objc func panRecognised(_ recognizer: UIPanGestureRecognizer) {
//        let trans = recognizer.translation(in: drawer).y
//
//        switch recognizer.state {
//        case .began where state == .partiallyOpen && recognizer.velocity(in: drawer).y < 0:
//            panState = .opening
//        case .began where state == .fullyOpen && recognizer.velocity(in: drawer).y < 0:
//            panState = .rubberbanding
//        case .began where state == .fullyOpen:
//            panState = .closing
//
//        case .changed where panState == .rubberbanding:
//            if trans + rubberbandingTransModifier > 0 {
//                panState = .closing
//                overOpenAnimator.isReversed = true
//                overOpenAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
//                break
//            }
//
//            overOpenAnimator.isReversed = false
//            overOpenAnimator.fractionComplete = pow(-(trans + rubberbandingTransModifier), 0.7) / 100
//
//        case .ended where panState == .rubberbanding:
//            overOpenAnimator.isReversed = true
//            overOpenAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
//            state = .fullyOpen
//
//        case .changed where panState == .closing:
//            if rubberbandingTransModifier > 0 {
//                openAnimator.isReversed = false
//                print((1 - (trans + rubberbandingTransModifier) / 400))
//                openAnimator.fractionComplete = (1 - (trans + rubberbandingTransModifier) / 400)
//            } else {
//                openAnimator.isReversed = true
//                openAnimator.fractionComplete = (trans + rubberbandingTransModifier) / 400
//            }
//
//
//            if trans + rubberbandingTransModifier < 0 { panState = .rubberbanding }
//
//        case .ended where panState == .closing:
//            openAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
//            state = .partiallyOpen
//
//        case .changed where panState == .opening:
//            openAnimator.isReversed = false
//            openAnimator.fractionComplete = -recognizer.translation(in: drawer).y / 400
//
//            if trans < -400 { panState = .rubberbanding; rubberbandingTransModifier = 400 }
//
//        case .ended where panState == .opening:
//            openAnimator.continueAnimation(withTimingParameters: params, durationFactor: 0)
//            state = .fullyOpen
//
//        default: break
//        }
//
////        print("OPEN:", openAnimator.fractionComplete, "OVEROPEN:", overOpenAnimator.fractionComplete)
//    }
    
    @IBAction func expandTapped() {
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        animator.addAnimations {
            self.constraint.constant = -100
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
        animator.addCompletion() { pos in
            if pos == .end { self.state = .partiallyOpen }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

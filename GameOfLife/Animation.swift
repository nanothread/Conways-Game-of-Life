//
//  Animation.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 04/02/2019.
//  Copyright © 2019 Andrew Glen. All rights reserved.
//

import UIKit

// Taken from https://medium.com/@nathangitter/building-fluid-interfaces-ios-swift-9732bb934bf5
extension UISpringTimingParameters {
    /// - Parameters:
    ///   - damping: Lower damping = more oscillation. Damping of 1.0 = no oscillation.
    ///   - response: Lower response = faster animation.
    convenience init(damping: CGFloat, response: CGFloat, initialVelocity: CGVector = .zero) {
        let stiffness = pow(2 * .pi / response, 2)
        let damp = 4 * .pi * damping / response
        self.init(mass: 1, stiffness: stiffness, damping: damp, initialVelocity: initialVelocity)
    }
}

extension UIView {
    func animateLayout(damping: CGFloat = 1, response: CGFloat = 0.3) {
        let params = UISpringTimingParameters(damping: damping, response: response)
        let animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        animator.addAnimations {
            self.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
}

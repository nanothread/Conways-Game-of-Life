//
//  Toolbar.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 19/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

protocol ToolbarDelegate: class {
    func toolPickerDidReceiveTap()
    func playPauseButtonDidReceiveTap()
    func settingsButtonDidReceiveTap()
    func speedSliderDidChangeValue(to value: Float)
}

enum Tool {
    case hand, brush
    
    mutating func toggle() {
        switch self {
        case .hand: self = .brush
        case .brush: self = .hand
        }
    }
}

class Toolbar: UIView {
    @IBOutlet var view: UIView!
    
    @IBOutlet var settingsView: UIView!
    @IBOutlet var multiPurposeView: UIView!
    @IBOutlet var playPauseView: UIView!
    
    @IBOutlet var toolPickerView: UIView!
    @IBOutlet var handImageView: UIImageView!
    @IBOutlet var brushImageView: UIImageView!
    
    @IBOutlet var playImageView: UIImageView!
    @IBOutlet var pauseImageView: UIImageView!
    
    @IBOutlet var speedSliderView: UIView!
    @IBOutlet var speedSlider: UISlider!
    
    @IBOutlet var pausedConstraints: [NSLayoutConstraint]!
    @IBOutlet var playingConstraints: [NSLayoutConstraint]!
    
    weak var delegate: ToolbarDelegate?
    var selectedTool: Tool = .hand {
        didSet {
            handImageView.isHighlighted = selectedTool == .hand
            brushImageView.isHighlighted = selectedTool == .brush
        }
    }
    
    @objc private func settingsViewTapped() {
        delegate?.settingsButtonDidReceiveTap()
    }
    @objc private func playPauseViewTapped() {
        delegate?.playPauseButtonDidReceiveTap()
    }
    @objc private func toolPickerTapped() {
        selectedTool.toggle()
        delegate?.toolPickerDidReceiveTap()
    }
    
    @IBAction func sliderValueChanged() {
        delegate?.speedSliderDidChangeValue(to: speedSlider.value)
    }
    
    func changeConstraintsForState(playing: Bool) {
        pausedConstraints.forEach { $0.isActive = !playing }
        playingConstraints.forEach  { $0.isActive = playing }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = .clear
        
        // Load from nib
        Bundle.main.loadNibNamed("Toolbar", owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v": view]))
        
        // Setup tap recognisers]
        settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsViewTapped)))
        toolPickerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toolPickerTapped)))
        playPauseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playPauseViewTapped)))
        
        handImageView.isHighlighted = true
    }
}

//
//  OptionsView.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 22/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

protocol OptionsViewDelegate: class {
    func optionsViewPanBegan()
    func optionsViewHeightShouldChange(verticalTranslation trans: CGFloat)
    func optionsViewPanEnded()
}

class OptionsView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = collectionManager
            collectionView.delegate = collectionManager
        }
    }
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewFlowLayout.estimatedItemSize = OptionCell.estimatedSize
        }
    }
    
    let collectionManager: OptionsCollectionManager = OptionsCollectionManager()
    lazy var panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panRecognized))
    
    weak var delegate: OptionsViewDelegate?
    
    @objc private func panRecognized() {
        let trans = panRecognizer.translation(in: self).y
        
        switch panRecognizer.state {
        case .began:
            delegate?.optionsViewPanBegan()
            
        case .changed:
            delegate?.optionsViewHeightShouldChange(verticalTranslation: trans)
            
        case .ended, .cancelled:
            delegate?.optionsViewPanEnded()
            
        default: break
        }
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
        Bundle.main.loadNibNamed("OptionsView", owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v": view]))
        
        collectionView.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: "option")
        
        addGestureRecognizer(panRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 15
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

class OptionsViewConstraintManager: NSObject {
    enum State {
        case closed, partiallyOpen, fullyOpen
    }
    
    @IBOutlet var closedConstraints: [NSLayoutConstraint] = []
    @IBOutlet var partiallyOpenConstraints: [NSLayoutConstraint] = []
    @IBOutlet var fullyOpenConstraints: [NSLayoutConstraint] = []
    
    var animator: UIViewPropertyAnimator?
    private var animationProgress: CGFloat = 0
    
    var state: State = .closed {
        didSet {
            (closedConstraints + fullyOpenConstraints + partiallyOpenConstraints).forEach {
                $0.isActive = false
            }
            activeConstraints(for: state).forEach {
                $0.isActive = true
            }
        }
    }
    
    func panBegan(optionsViewHeight height: CGFloat, layoutViewCode: @escaping () -> Void) {
        let params = UISpringTimingParameters(damping: 1, response: 0.3)
        animator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        animator?.addAnimations {
            self.state = .closed
            layoutViewCode()
        }
        animator?.fractionComplete = animationProgress
    }
    func panChanged(translation trans: CGFloat, optionsViewHeight: CGFloat) {
        animator?.fractionComplete =  trans / optionsViewHeight
        animationProgress = trans / optionsViewHeight
    }
    func panEnded() {
        animator?.continueAnimation(withTimingParameters: UISpringTimingParameters(damping: 1, response: 1), durationFactor: 0)
    }
    
    // TODO: Update this functionality to work with parially open states.
    func suggestedNextState() -> State {
        switch state {
        case .closed: return .fullyOpen
        case .partiallyOpen: return .fullyOpen
        case .fullyOpen: return .closed
        }
    }
    
    private func activeConstraints(for state: State) -> [NSLayoutConstraint] {
        switch state {
        case .closed: return closedConstraints
        case .partiallyOpen: return partiallyOpenConstraints
        case .fullyOpen: return fullyOpenConstraints
        }
    }
}

class OptionsCollectionManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var data = MenuOption.loadOptionsFromBundle()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "option", for: indexPath)
        
        (cell as? OptionCell)?.configure(with: data[indexPath.item])
        
        return cell
    }
}

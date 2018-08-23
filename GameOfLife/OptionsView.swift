//
//  OptionsView.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 22/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

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

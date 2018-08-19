//
//  Toolbar.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 19/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

class Toolbar: UIView {
    @IBOutlet var view: UIView!
    
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
        
        Bundle.main.loadNibNamed("Toolbar", owner: self, options: nil)
        view.frame = bounds
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[v]-(0)-|", options: [], metrics: nil, views: ["v": view]))
    }
}

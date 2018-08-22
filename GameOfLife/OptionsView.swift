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
    
    lazy var options: [MenuOption] = MenuOption.loadOptionsFromBundle()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        print("Menu Options:", options.count)
    }
}

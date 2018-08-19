//
//  ToolbarView.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 19/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

class ToolbarView: ButtonContainer {
    
    // TODO: Use a more safe way of getting the buttons, i.e. separate nib file
    var handButton: UIButton!
    var brushButton: UIButton!
    
    @objc func buttonTapped() {
        [handButton, brushButton].forEach {
            $0?.isSelected.toggle()
            // Can't re-select the currently selected button
            $0?.isUserInteractionEnabled = !$0!.isSelected
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
    
    private func setup() {
        handButton = viewWithTag(1) as? UIButton
        brushButton = viewWithTag(2) as? UIButton
        
        handButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        brushButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

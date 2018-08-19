//
//  Cell.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import SpriteKit

class Cell: SKShapeNode, CellProtocol {
    static let size: CGFloat = 50
    static let deadColor = SKColor.white
    
    var aliveColor: SKColor
    
    var isAlive = false {
        didSet {
            updateUI()
        }
    }
    
    init(origin: CGPoint, aliveColor: SKColor) {
        self.aliveColor = aliveColor
        
        super.init()
        path = UIBezierPath(rect: CGRect(origin: origin, size: CGSize(width: Cell.size, height: Cell.size))).cgPath
        fillColor = SKColor.white
    }
    
    private func updateUI() {
        fillColor = isAlive ? aliveColor : SKColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

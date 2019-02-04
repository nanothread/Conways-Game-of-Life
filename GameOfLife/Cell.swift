//
//  Cell.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2019 Andrew Glen. All rights reserved.
//

import SpriteKit

class Cell: SKShapeNode, CellProtocol {
    static let size: CGFloat = 50
    static let deadColor = SKColor(red: 238 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1)
    
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
        updateUI()
    }
    
    private func updateUI() {
        fillColor = isAlive ? aliveColor : Cell.deadColor
        lineWidth = isAlive ? 0 : 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

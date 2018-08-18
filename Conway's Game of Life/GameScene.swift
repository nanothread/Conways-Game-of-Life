//
//  GameScene.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var toggledNodes = [SKShapeNode]()
    private let gradient = Gradient(start: (192, 57, 43), end: (142, 68, 173))
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = SKColor.white
        
        let rows = Int(view.frame.width / Cell.size)
        let columns = Int(view.frame.height / Cell.size)
        let maxDistanceFromTopLeft = sqrt(pow(CGFloat(rows - 1), 2) + pow(CGFloat(columns - 1), 2))
        
        for i in 0 ..< rows {
            for j in 0 ..< columns {
                // Using `columns - j - 1` because y = 0 is in the bottom left, so the y value of the cells should be reversed to get the distance from the top left.
                // If you use `j * j` then the gradient will be from bottom left to top right instead of top left to bottom right.
                let distanceFromTopLeft = sqrt(CGFloat(i * i) + pow(CGFloat(columns - j - 1), 2))
                let fractionFromTopLeft = distanceFromTopLeft / maxDistanceFromTopLeft
                
                let cell = Cell(origin: CGPoint(x: CGFloat(i) * Cell.size,
                                                y: CGFloat(j) * Cell.size),
                                aliveColor: gradient.color(forFraction: fractionFromTopLeft))
                
                cell.isAlive = true
                
                addChild(cell)
            }
        }
    }
    
    func reverseColorOfNode(at point: CGPoint) {
        for case let cell as Cell in nodes(at: point) where !toggledNodes.contains(cell) {
            cell.isAlive.toggle()
            toggledNodes.append(cell)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        reverseColorOfNode(at: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        reverseColorOfNode(at: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggledNodes.removeAll()
    }
}

extension SKColor {
    static func random() -> SKColor {
        return SKColor(red: CGFloat.random(in: 0 ... 1),
                       green: CGFloat.random(in: 0 ... 1),
                       blue: CGFloat.random(in: 0 ... 1),
                       alpha: 1)
    }
}

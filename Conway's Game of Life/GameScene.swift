//
//  GameScene.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backgroundColor = SKColor.white
        
        let shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 256, height: 256), cornerRadius: 64).cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.fillColor = UIColor.red
        shape.strokeColor = UIColor.blue
        shape.lineWidth = 10
        addChild(shape)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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

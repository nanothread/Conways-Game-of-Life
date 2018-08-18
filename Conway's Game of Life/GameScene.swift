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
        
        for i in 0 ..< Int(view.frame.width / 25) {
            for j in 0 ..< Int(view.frame.height / 25) {
                let shape = SKShapeNode(rect: CGRect(x: CGFloat(i) * view.frame.width / 25,
                                                     y: CGFloat(j) * view.frame.height / 25,
                                                     width: 40,
                                                     height: 40))
                shape.fillColor = SKColor.lightGray
                addChild(shape)
            }
        }
    }
    
    func reverseColorOfNode(at point: CGPoint) {
        for case let shape as SKShapeNode in nodes(at: point) {
            shape.fillColor = String(describing: shape.fillColor) == "UIExtendedSRGBColorSpace 1 1 1 1" ? SKColor.random() : SKColor.white
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first!.location(in: self)
//        reverseColorOfNode(at: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        reverseColorOfNode(at: location)
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

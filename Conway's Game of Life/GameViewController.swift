//
//  GameViewController.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    var gameView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: 1000, height: 1000)
        
        // Limit the UIScrollView scrolling gesture to only activate on a 2-finger scroll
        if let recognisers = scrollView.gestureRecognizers {
            for case let panRecogniser as UIPanGestureRecognizer in recognisers {
                panRecogniser.minimumNumberOfTouches = 2
            }
        }
        
        if gameView == nil {
            gameView = SKView(frame: CGRect(origin: .zero, size: scrollView.contentSize))
            scrollView.addSubview(gameView)
            
            let scene = GameScene()
            scene.scaleMode = .resizeFill
            
            gameView.presentScene(scene)
            
            gameView.ignoresSiblingOrder = true
            gameView.showsFPS = true
            gameView.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

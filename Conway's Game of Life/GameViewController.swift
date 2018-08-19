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

class ScrollViewManager: NSObject, UIScrollViewDelegate {
    weak var zoomView: UIView?
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomView
    }
}

class GameViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = scrollManager
        }
    }
    var gameView: SKView! {
        didSet {
            scrollManager.zoomView = gameView
            gameView.isUserInteractionEnabled = false
        }
    }
    lazy var scrollManager: ScrollViewManager = ScrollViewManager()
    
    var gameController: GameController!
    
    @IBAction func playTapped() {
        gameController.play()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: 1000, height: 1000)
        
        if gameView == nil {
            gameView = SKView(frame: CGRect(origin: .zero, size: scrollView.contentSize))
            scrollView.addSubview(gameView)
            
            let scene = GameScene()
            scene.scaleMode = .resizeFill
            
            gameView.presentScene(scene)
            
            gameController = GameController(columns: 20, cells: scene.cells)
            
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

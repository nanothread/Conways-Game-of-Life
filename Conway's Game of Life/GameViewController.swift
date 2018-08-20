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
    @IBOutlet var toolbar: Toolbar! {
        didSet {
            toolbar.delegate = self
        }
    }
    
    @IBOutlet var pausedToolbarHeight: NSLayoutConstraint!
    @IBOutlet var playingToolbarHeight: NSLayoutConstraint!
    
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
        
//        toolbar.playingConstraints.append(playingToolbarHeight)
//        toolbar.pausedConstraints.append(pausedToolbarHeight)
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

extension GameViewController: ToolbarDelegate {
    func toolPickerDidReceiveTap() {
        let handSelected = toolbar.selectedTool == .hand
        scrollView.isScrollEnabled = handSelected
        gameView.isUserInteractionEnabled = !handSelected
    }
    
    // TODO: Tidy up this implementation, possibly by having a larger view that contains all toolbar logic
    func playPauseButtonDidReceiveTap() {
        if gameController.isGameRunning {
            gameController.pause()
        }
        else {
            gameController.play()
        }
        
        toolbar.changeConstraintsForState(playing: gameController.isGameRunning)
        
        playingToolbarHeight.isActive = gameController.isGameRunning
        pausedToolbarHeight.isActive = !gameController.isGameRunning
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func settingsButtonDidReceiveTap() {
        print("Settings")
    }
}

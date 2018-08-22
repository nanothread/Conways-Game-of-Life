//
//  GameController.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 19/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

class GameController {
    /// Tick frequency in Hz
    var tickFrequency: Double = 2
    private var tickInterval: TimeInterval { return 1 / tickFrequency }
    var model: GameModel
    
    var isGameRunning: Bool { return displayLink != nil }
    private var lastTickTimestamp: TimeInterval = 0
    private var displayLink: CADisplayLink?
    
    init(columns: Int, cells: [CellProtocol]) {
        self.model = GameModel(columns: columns, cells: cells)
    }
    
    func play() {
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkTick(_:)))
        // Adding to .common means the sim won't pause when the scroll view is scrolloing or zooming.
        displayLink!.add(to: .current, forMode: .common)
    }
    func pause() {
        displayLink?.remove(from: .current, forMode: .common)
        displayLink = nil
    }
    
    @objc private func displayLinkTick(_ link: CADisplayLink) {
        guard lastTickTimestamp > 0 else {
            lastTickTimestamp = link.timestamp
            return
        }
        
        let timeElapsed = link.timestamp - lastTickTimestamp
        
        if timeElapsed > tickInterval {
            model.tick()
            lastTickTimestamp = link.timestamp
        }
    }
}

//
//  GameController.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 19/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import Foundation

class GameController {
    /// Tick frequency in Hz
    var tickFrequency: Double = 2
    var model: GameModel
    
    private var timer: Timer?
    var isGameRunning: Bool { return timer?.isValid ?? false }
    
    init(columns: Int, cells: [CellProtocol]) {
        self.model = GameModel(columns: columns, cells: cells)
    }
    
    func play() {
        timer = Timer.scheduledTimer(withTimeInterval: 1 / tickFrequency, repeats: true) { _ in
            self.model.tick()
        }
    }
    func pause() {
        timer?.invalidate()
    }
}

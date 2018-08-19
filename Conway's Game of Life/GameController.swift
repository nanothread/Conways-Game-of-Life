//
//  GameController.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 19/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import Foundation

class GameController {
    var model: GameModel
    
    init(columns: Int, cells: [CellProtocol]) {
        self.model = GameModel(columns: columns, cells: cells)
    }
    
    func play() {
        model.tick()
    }
}

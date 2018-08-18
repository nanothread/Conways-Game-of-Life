//
//  GameModel.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import Foundation

/// Bound to class because the cells alive values must be passed by reference when copying to `oldCells` in `tick`
protocol CellProtocol: class {
    var isAlive: Bool { get set }
}

/// Assumes a square matrix, `columns` x `columns`
class GameModel {
    var columns: Int
    var cells: [CellProtocol]
    
    init(columns: Int, cells: [CellProtocol]) {
        // Make sure that the number of states (cells) is divisible by the number of columns
        assert(cells.count / columns == Int(cells.count / columns))
        
        self.columns = columns
        self.cells = cells
    }
    
    func tick() {
        let currentAliveValues = cells.map { $0.isAlive }
        
        print("\n\nCells before:", cells.map { $0.isAlive })
        
        // Trying to do this in the least computationally expensive way
        for (index, cell) in cells.enumerated() {
            let livingNeighbours = getNeighbourIndicesOfCell(at: index).filter { currentAliveValues[$0] }.count
            
            print("Index:", index, "livingNeighbours:", livingNeighbours)
            
            if cell.isAlive && (livingNeighbours < 2 || livingNeighbours > 3) {
                cell.isAlive = false
            }
            else if !cell.isAlive && livingNeighbours == 3 {
                cell.isAlive = true
            }
        }
        
        print("Cells after:", cells.map { $0.isAlive }, "\n\n")
    }
    
    func getNeighbourIndicesOfCell(at index: Int) -> [Int] {
        var indices = [Int]()
        
        let canAdd: (top: Bool, bottom: Bool, left: Bool, right: Bool) = (
            top:        index >= columns,
            bottom:     index < columns * (columns - 1),
            left:       index % columns > 0,
            right:      index % columns < columns - 1
        )
        
        print("\n\nIndex: \(index); canAdd: \(canAdd)\n\n")
        
        // TODO: Refactor this into a fancy switch statement
        if canAdd.top {
            indices.append(index - columns)
        }
        if canAdd.bottom {
            indices.append(index + columns)
        }
        if canAdd.left {
            indices.append(index - 1)
        }
        if canAdd.right {
            indices.append(index + 1)
        }
        
        if canAdd.top && canAdd.left {
            indices.append(index - columns - 1)
        }
        if canAdd.top && canAdd.right {
            indices.append(index - columns + 1)
        }
        if canAdd.bottom && canAdd.left {
            indices.append(index + columns - 1)
        }
        if canAdd.bottom && canAdd.right {
            indices.append(index + columns + 1)
        }
        
        return indices
    }
}

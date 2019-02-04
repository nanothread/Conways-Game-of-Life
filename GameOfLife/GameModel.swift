//
//  GameModel.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2019 Andrew Glen. All rights reserved.
//

import Foundation

// Bound to class because the cells' alive values must be passed by reference when copying to `oldCells` in `tick`
/// Describes a single cell in the grid.
protocol CellProtocol: class {
    var isAlive: Bool { get set }
}

/// Powers the logic behind each timer tick. Assumes a square matrix, `columns` x `columns`
class GameModel {
    var columns: Int
    var cells: [CellProtocol]
    
    private var verbose = false
    
    init(columns: Int, cells: [CellProtocol], verbose: Bool = false) {
        // Make sure that the number of cells is divisible by the number of columns
        assert(Double(cells.count).truncatingRemainder(dividingBy: Double(columns)) == 0)
        assert(cells.count == columns * columns, "Matrix must be square. Columns: \(columns); Rows: \(cells.count / columns)")
        
        self.columns = columns
        self.cells = cells
        self.verbose = verbose
    }
    
    func tick() {
        let currentAliveValues = cells.map { $0.isAlive }
        
        if verbose { print("\n\nCells before:", cells.map { $0.isAlive }) }
        
        // Attempting to do this in a fairly non computationally expensive way.
        // TODO: optimise
        for (index, cell) in cells.enumerated() {
            let livingNeighbours = getNeighbourIndicesOfCell(at: index).filter { currentAliveValues[$0] }.count
            
            if verbose { print("Index:", index, "livingNeighbours:", livingNeighbours) }
            
            if cell.isAlive && (livingNeighbours < 2 || livingNeighbours > 3) {
                cell.isAlive = false
            }
            else if !cell.isAlive && livingNeighbours == 3 {
                cell.isAlive = true
            }
        }
        
        if verbose { print("Cells after:", cells.map { $0.isAlive }, "\n\n") }
    }
    
    func getNeighbourIndicesOfCell(at index: Int) -> [Int] {
        var indices = [Int]()
        
        let canAdd: (top: Bool, bottom: Bool, left: Bool, right: Bool) = (
            top:        index >= columns,
            bottom:     index < columns * (columns - 1),
            left:       index % columns > 0,
            right:      index % columns < columns - 1
        )
        
        if verbose { print("\n\nIndex: \(index); canAdd: \(canAdd)\n\n") }
        
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

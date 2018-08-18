//
//  GameModel_Tick_Tests.swift
//  Conway's Game of LifeTests
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import XCTest
@testable import Conway_s_Game_of_Life

class DummyCell: CellProtocol {
    var isAlive: Bool = false
}

/// Test that when the model ticks, it applies the rules of the game to each cell correctly
class GameModel_Tick_Tests: XCTestCase {
    func dummyCells(fromBinaryArray arr: [Int]) -> [DummyCell] {
        return arr.map {
            let cell = DummyCell()
            cell.isAlive = $0 != 0
            return cell
        }
    }
    func indicesOfAliveCells(fromModel model: GameModel) -> [Int] {
        return model.cells.indices.filter { model.cells[$0].isAlive }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: -Test Ticks-
    // MARK: One Cell
    func testSingleCell() {
        let layout =
        [
            0, 0, 0,
            0, 1, 0,
            0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [], "Indices: \(indices)")
    }
    // MARK: Two Cells
    func testTwoCells() {
        let layout =
            [
                0, 0, 0,
                0, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [], "Indices: \(indices)")
    }
    // MARK: Three Cells
    func testThreeCells() {
        let layout =
            [
                0, 0, 0,
                1, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [1, 4, 7], "Indices: \(indices)")
    }
    func testThreeCells_twoTicks() {
        let layout =
            [
                0, 0, 0,
                1, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [3, 4, 5], "Indices: \(indices)")
    }
    
    // MARK: Four Cells
    func testFourCellsSquare() {
        let layout =
            [
                0, 1, 1,
                0, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [1, 2, 4, 5], "Indices: \(indices)")
    }
    func testFourCellsSquare_threeTicks() {
        let layout =
            [
                0, 1, 1,
                0, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        model.tick()
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [1, 2, 4, 5], "Indices: \(indices)")
    }
    func testFourCellsSnake() {
        let layout =
            [
                1, 1, 0,
                0, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [0, 1, 2, 3, 4, 5], "Indices: \(indices)")
    }
    func testFourCellsSnake_twoTicks() {
        let layout =
            [
                1, 1, 0,
                0, 1, 1,
                0, 0, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [0, 2, 3, 5, 7], "Indices: \(indices)")
    }
    
    // MARK: Five Cells
    func testFiveCellsPlus() {
        let layout =
            [
                0, 1, 0,
                1, 1, 1,
                0, 1, 0
        ]
        let model = GameModel(columns: 3, cells: dummyCells(fromBinaryArray: layout))
        model.tick()
        let indices = indicesOfAliveCells(fromModel: model)
        XCTAssert(indices.sorted() == [0, 1, 2, 3, 5, 6, 7, 8], "Indices: \(indices)")
    }
}

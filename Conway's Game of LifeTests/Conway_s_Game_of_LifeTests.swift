//
//  Conway_s_Game_of_LifeTests.swift
//  Conway's Game of LifeTests
//
//  Created by Andrew Glen on 18/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import XCTest
@testable import Conway_s_Game_of_Life

/// Test that the `GameModel` will always return the correct indices of the neighbouring cells for any given cell.
class Conway_s_Game_of_LifeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test 3x3 Grid -
    // MARK: Corners
    func test_3x3_TopLeft() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 0)
        XCTAssert(indices.sorted() == [1, 3, 4], "Indices: \(indices)")
    }
    
    func test_3x3_TopRight() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 2)
        XCTAssert(indices.sorted() == [1, 4, 5], "Indices: \(indices)")
    }
    
    func test_3x3_BottomLeft() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 6)
        XCTAssert(indices.sorted() == [3, 4, 7], "Indices: \(indices)")
    }
    
    func test_3x3_BottomRight() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 8)
        XCTAssert(indices.sorted() == [4, 5, 7], "Indices: \(indices)")
    }
    
    // MARK: Edges
    func test_3x3_TopMiddle() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 1)
        XCTAssert(indices.sorted() == [0, 2, 3, 4, 5], "Indices: \(indices)")
    }
    func test_3x3_BottomMiddle() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 7)
        XCTAssert(indices.sorted() == [3, 4, 5, 6, 8], "Indices: \(indices)")
    }
    func test_3x3_LeftMiddle() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 3)
        XCTAssert(indices.sorted() == [0, 1, 4, 6, 7], "Indices: \(indices)")
    }
    func test_3x3_RightMiddle() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 5)
        XCTAssert(indices.sorted() == [1, 2, 4, 7, 8], "Indices: \(indices)")
    }
    
    // MARK: Middle
    func test_3x3_Middle() {
        let model = GameModel(columns: 3, cells: Array(repeating: DummyCell(), count: 9))
        let indices = model.getNeighbourIndicesOfCell(at: 4)
        XCTAssert(indices.sorted() == [0, 1, 2, 3, 5, 6, 7, 8], "Indices: \(indices)")
    }
    
    // MARK: - Test 5x5 Grid -
    // MARK: Corners
    func test_5x5_TopLeft() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 0)
        XCTAssert(indices.sorted() == [1, 5, 6], "Indices: \(indices)")
    }
    
    func test_5x5_TopRight() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 4)
        XCTAssert(indices.sorted() == [3, 8, 9], "Indices: \(indices)")
    }
    
    func test_5x5_BottomLeft() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 20)
        XCTAssert(indices.sorted() == [15, 16, 21], "Indices: \(indices)")
    }
    
    func test_5x5_BottomRight() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 24)
        XCTAssert(indices.sorted() == [18, 19, 23], "Indices: \(indices)")
    }
    
    // MARK: Edges
    func test_5x5_TopMiddle() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 2)
        XCTAssert(indices.sorted() == [1, 3, 6, 7, 8], "Indices: \(indices)")
    }
    func test_5x5_BottomMiddle() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 22)
        XCTAssert(indices.sorted() == [16, 17, 18, 21, 23], "Indices: \(indices)")
    }
    func test_5x5_LeftMiddle() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 10)
        XCTAssert(indices.sorted() == [5, 6, 11, 15, 16], "Indices: \(indices)")
    }
    func test_5x5_RightMiddle() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 14)
        XCTAssert(indices.sorted() == [8, 9, 13, 18, 19], "Indices: \(indices)")
    }
    
    // MARK: Middle
    func test_5x5_Middle() {
        let model = GameModel(columns: 5, cells: Array(repeating: DummyCell(), count: 25))
        let indices = model.getNeighbourIndicesOfCell(at: 12)
        XCTAssert(indices.sorted() == [6, 7, 8, 11, 13, 16, 17, 18], "Indices: \(indices)")
    }
}

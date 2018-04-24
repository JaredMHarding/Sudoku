//
//  Sudoku.swift
//  Sudoku
//
//  Created by Jared Micheal Harding on 4/23/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import Foundation

class Sudoku: Codable {
    
    var puzzleValues: [[Int]] = [
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0]
    ]
    
    func numberAt(row r: Int, column c: Int) -> Int {
        return 0
    }
    
    func numberIsFixedAt(row r: Int, column c: Int) -> Bool {
        return false
    }
    
    func isConflictingEntryAt(row r: Int, column c: Int) -> Bool {
        return false
    }
    
    func anyPencilSetAt(row r: Int, column c: Int) -> Bool {
        return false
    }
    
    func isSetPencil(_ n: Int, row r: Int, column c: Int) -> Bool {
        return false
    }
    
}

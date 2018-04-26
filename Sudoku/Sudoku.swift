//
//  Sudoku.swift
//  Sudoku
//
//  Created by Jared Micheal Harding on 4/23/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import Foundation

class Sudoku: Codable {
    
    struct Cell: Codable {
        var value: Int
        var pencilValues: [Bool]
        var fixed: Bool
        
        static let resetPencilValues = [false,false,false,false,false,false,false,false,false]
    }
    
    // puzzle will have no nils after initialization
    var puzzle: [[Cell?]] = [
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil],
        [nil,nil,nil,nil,nil,nil,nil,nil,nil]
    ]
    
    init(puzzleString ps: String) {
        var row = 0, col = 0
        assert(ps.count == 81)
        for char in ps {
            if (char == ".") {
                puzzle[row][col] = Cell(value: 0,pencilValues: Cell.resetPencilValues,fixed: false)
            } else {
                puzzle[row][col] = Cell(value: Int("\(char)")!,pencilValues: Cell.resetPencilValues,fixed: true)
            }
            // increment indices
            col += 1
            if (col == 9) {
                row += 1
                col = 0
            }
        }
    }
    
    func numberAt(row r: Int, column c: Int) -> Int {
        return puzzle[r][c]!.value
    }
    
    func numberIsFixedAt(row r: Int, column c: Int) -> Bool {
        return puzzle[r][c]!.fixed
    }
    
    func isConflictingEntryAt(row r: Int, column c: Int) -> Bool {
        let value = puzzle[r][c]!.value
        // test same col
        for i in 0..<9 {
            if ((i != r) && (puzzle[i][c]!.value == value)) {
                return true
            }
        }
        // test same row
        for j in 0..<9 {
            if ((j != c) && (puzzle[r][j]!.value == value)) {
                return true
            }
        }
        // test same 3x3 square
        let TLRowIndex = r - (r % 3)
        let TLColIndex = c - (c % 3)
        // if you don't do for loops like this with an upperbound of 3... you're heartless
        for i in 0..<3 {
            for j in 0..<3 {
                if ((TLRowIndex+i != r) || (TLColIndex+j != c)) {
                    if (puzzle[TLRowIndex+i][TLColIndex+j]!.value == value) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func anyPencilSetAt(row r: Int, column c: Int) -> Bool {
        for i in 0..<9 {
            if (puzzle[r][c]!.pencilValues[i] == true) {
                return true
            }
        }
        return false
    }
    
    func isSetPencil(_ n: Int, row r: Int, column c: Int) -> Bool {
        return puzzle[r][c]!.pencilValues[n-1]
    }
    
}

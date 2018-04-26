//
//  GameViewController.swift
//  Sudoku
//
//  Created by Jared Micheal Harding on 4/23/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var PuzzleView: SudokuView!
    var pencilEnabled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pencilPressed(_ sender: UIButton) {
        pencilEnabled = !pencilEnabled
        sender.isSelected = pencilEnabled
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let row = PuzzleView.selected.row
        let column = PuzzleView.selected.column
        if ((row < 0) || (column < 0)) {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let buttonValue = Int(sender.currentTitle!)!
        // check if the cell is empty
        if (appDelegate.sudoku!.puzzle[row][column]!.value == 0) {
            // check pencil values
            if (pencilEnabled == true) {
                // toggle the pencil value
                appDelegate.sudoku!.puzzle[row][column]!.pencilValues[buttonValue-1] = !(appDelegate.sudoku!.puzzle[row][column]!.pencilValues[buttonValue-1])
            } else {
                appDelegate.sudoku!.puzzle[row][column]!.value = buttonValue
                appDelegate.sudoku!.puzzle[row][column]!.pencilValues = Sudoku.Cell.resetPencilValues
            }
        } else if (appDelegate.sudoku!.puzzle[row][column]!.value == buttonValue) {
            appDelegate.sudoku!.puzzle[row][column]!.value = 0
        } else {
            return
        }
        PuzzleView.setNeedsDisplay()
    }
    
    @IBAction func clearPressed() {
        let row = PuzzleView.selected.row
        let column = PuzzleView.selected.column
        if ((row < 0) || (column < 0)) {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // clear the cell
        appDelegate.sudoku!.puzzle[row][column]!.value = 0
        appDelegate.sudoku!.puzzle[row][column]!.pencilValues = Sudoku.Cell.resetPencilValues
        PuzzleView.setNeedsDisplay()
    }
    
    @IBAction func leaveGamePressed() {
        let alert = UIAlertController(title: "Are you sure you want to abandon your current game?",
                                      message: "Your game data will not be saved.",
                                      preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Yes", style: .destructive, handler: {
            action in
            // delete saved game and return to the title screen
            self.performSegue(withIdentifier: "gameToTitle", sender: self)
        })
        let alertActionNo = UIAlertAction(title: "No", style: .cancel, handler: {
            action in
            // do nothing :)
        })
        alert.addAction(alertActionYes)
        alert.addAction(alertActionNo)
        self.present(alert, animated: true, completion: nil)
    }
}

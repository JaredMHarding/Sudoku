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
    var pencilOn: Bool = false
    var leaveGameButtonPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // see if it was the leave game button that was pressed
        if (leaveGameButtonPressed) {
            leaveGameButtonPressed = false
            appDelegate.savedGameURL = nil
            return
        }
        // save the current game if leaving normally
        let propertyListEncoder = PropertyListEncoder()
        if let encodedSudoku = try? propertyListEncoder.encode(appDelegate.sudoku) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentsDirectory.appendingPathComponent("savedSudoku").appendingPathExtension("plist")
            try? encodedSudoku.write(to: archiveURL)
            appDelegate.savedGameURL = archiveURL
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pencilPressed(_ sender: UIButton) {
        pencilOn = !pencilOn
        sender.isSelected = pencilOn
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
            if (pencilOn == true) {
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
        // check if the puzzle is solved
        if (appDelegate.sudoku!.isSolved()) {
            // the player won
            let alert = UIAlertController(title: "You've won!",
                                          message: "What would you like to do now?",
                                          preferredStyle: .actionSheet)
            let alertActionTitleScreen = UIAlertAction(title: "Return To Title Screen", style: .default, handler: {
                action in
                // same as if you pressed yes on the leave game alert screen
                self.leaveGameButtonPressed = true
                self.performSegue(withIdentifier: "gameToTitle", sender: self)
            })
            let alertActionContinue = UIAlertAction(title: "Return To Current Game", style: .cancel, handler: {
                action in
                // do nothing
            })
            alert.addAction(alertActionTitleScreen)
            alert.addAction(alertActionContinue)
            self.present(alert, animated: true, completion: nil)
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
        appDelegate.sudoku!.clearCell(row,column)
        PuzzleView.setNeedsDisplay()
    }
    
    @IBAction func menuPressed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let alert = UIAlertController(title: "Menu",
                                      message: "",
                                      preferredStyle: .actionSheet)
        let alertActionReturn = UIAlertAction(title: "Return", style: .cancel, handler: {
            action in
            // do nothing
        })
        let alertActionClearConflicting = UIAlertAction(title: "Clear All Conflicting Cells", style: .default, handler: {
            action in
            appDelegate.sudoku!.clearConflicting()
            self.PuzzleView.setNeedsDisplay()
        })
        let alertActionClearAll = UIAlertAction(title: "Clear All Cells", style: .destructive, handler: {
            action in
            appDelegate.sudoku!.clearAll()
            self.PuzzleView.setNeedsDisplay()
        })
        alert.addAction(alertActionReturn)
        alert.addAction(alertActionClearConflicting)
        alert.addAction(alertActionClearAll)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func leaveGamePressed() {
        let alert = UIAlertController(title: "Are you sure you want to abandon your current game?",
                                      message: "Your game data will not be saved.",
                                      preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Yes", style: .destructive, handler: {
            action in
            // this will delete saved game and return to the title screen
            self.leaveGameButtonPressed = true
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

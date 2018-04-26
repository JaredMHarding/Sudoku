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
        
        appDelegate.sudoku!.puzzle[row][column]!.value = buttonValue
        PuzzleView.setNeedsDisplay()
    }
    
}

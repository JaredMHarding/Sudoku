//
//  TitleViewController.swift
//  Sudoku
//
//  Created by Jared Micheal Harding on 4/24/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindFunction(unwindSegue: UIStoryboardSegue) {
        // doesn't need to do anything
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (sender.tag == 1) {
            let simples = appDelegate.simplePuzzles
            let random = Int(arc4random_uniform(UInt32(simples.count)))
            let ps = simples[random]
            appDelegate.sudoku = Sudoku(puzzleString: ps)
        } else if (sender.tag == 2) {
            let hards = appDelegate.hardPuzzles
            let random = Int(arc4random_uniform(UInt32(hards.count)))
            let ps = hards[random]
            appDelegate.sudoku = Sudoku(puzzleString: ps)
        }
        else if (sender.tag == 3) {
            
        }
    }
    
}


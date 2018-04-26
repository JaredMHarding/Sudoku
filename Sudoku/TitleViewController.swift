//
//  TitleViewController.swift
//  Sudoku
//
//  Created by Jared Micheal Harding on 4/24/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check if there is a saved game
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.savedGameURL != nil) {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (sender.tag == 3) {
            // continue game selected
            // if this happens, there is a saved game
            let propertyListDecoder = PropertyListDecoder()
            if let retrievedGameData = try? Data(contentsOf: appDelegate.savedGameURL!) {
                appDelegate.sudoku = try? propertyListDecoder.decode(Sudoku.self,from: retrievedGameData)
                performSegue(withIdentifier: "titleToGame", sender: self)
            }
        } else {
            // one of the other buttons was selected
            if (sender.tag == 1) {
                // new easy game selected
                if (appDelegate.savedGameURL != nil) {
                    // alert about overwritting the saved game
                    let alert = makeAlert(withPuzzles: appDelegate.simplePuzzles)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // no saved game, so just load the new one with no alert
                    loadNewRandomGame(withPuzzles: appDelegate.simplePuzzles)
                }
            } else if (sender.tag == 2) {
                // new hard game selected
                if (appDelegate.savedGameURL != nil) {
                    // alert about overwritting the saved game
                    let alert = makeAlert(withPuzzles: appDelegate.hardPuzzles)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // no saved game, so just load the new one with no alert
                    loadNewRandomGame(withPuzzles: appDelegate.hardPuzzles)
                }
            } else {
                // just covering bases
                return
            }
        }
    }
    
    func loadNewRandomGame(withPuzzles ps: [String]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let random = Int(arc4random_uniform(UInt32(ps.count)))
        let ps = ps[random]
        appDelegate.sudoku = Sudoku(puzzleString: ps)
        performSegue(withIdentifier: "titleToGame", sender: self)
    }
    
    func makeAlert(withPuzzles p: [String]) -> UIAlertController {
        let alert = UIAlertController(title: "Are you sure you want to overwrite your saved game?",
                                      message: "The current saved game will be lost.",
                                      preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Yes", style: .destructive, handler: {
            action in
            self.loadNewRandomGame(withPuzzles: p)
        })
        let alertActionNo = UIAlertAction(title: "No", style: .cancel, handler: {
            action in
            // do nothing
        })
        alert.addAction(alertActionYes)
        alert.addAction(alertActionNo)
        return alert
    }
    
    @IBAction func unwindFunction(unwindSegue: UIStoryboardSegue) {
        // doesn't need to do anything
    }
}

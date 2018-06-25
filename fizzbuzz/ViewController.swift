//
//  ViewController.swift
//  fizzbuzz
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: Game?
    var gameScore: Int? {
        didSet {
            guard let unwrappedScore = gameScore else {
                print("gameScore is nil")
                return
            }
            numberButton.setTitle("\(unwrappedScore)", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game()
        guard let unwrappedGame = game else {
            print("Game is nil!")
            return
        }
        
        gameScore = unwrappedGame.score
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func play(move: Move) {
        guard let unwrappedGame = game else {
            print("Game is nil!")
            return
        }
        let response = unwrappedGame.play(move: move)
        if !response.right {
            let alert = UIAlertController(title: "Wrong!", message: "You lost the game! Click OK to play again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    unwrappedGame.restartGame()
                    self.gameScore = 0
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.gameScore = response.score
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender {
        case numberButton:
            play(move: Move.number)
        case fizzButton:
            play(move: Move.fizz)
        case buzzButton:
            play(move: Move.buzz)
        case fizzBuzzButton:
            play(move: Move.fizzBuzz)
        default:
            print("Invalid selection")
        }
    }
    
    @IBOutlet weak var buzzButton: UIButton!
    @IBOutlet weak var fizzBuzzButton: UIButton!
    @IBOutlet weak var fizzButton: UIButton!
    @IBOutlet weak var numberButton: UIButton!
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        guard let unwrappedGame = game else {
            print("Game is nil!")
            return
        }
        unwrappedGame.restartGame()
        self.gameScore = 0
    }
    @IBOutlet weak var playAgainButton: UIButton!
    
}


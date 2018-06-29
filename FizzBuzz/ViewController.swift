//
//  ViewController.swift
//  fizzbuzz
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var timer: Timer?
    var seconds: Double = 30
    var status: Bool = false
    var highScore = 0
    
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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buzzButton: UIButton!
    @IBOutlet weak var fizzBuzzButton: UIButton!
    @IBOutlet weak var fizzButton: UIButton!
    @IBOutlet weak var numberButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game()
        guard let unwrappedGame = game else {
            print("Game is nil!")
            return
        }
        
        gameScore = unwrappedGame.score
        
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "highScore") != nil {
            highScore = (defaults.value(forKey: "highScore") as! Int)
        } else {
            highScore = 0
        }
        highScoreLabel.text = NSString(format: "High Score: %i", highScore) as String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateCounter)), userInfo: nil, repeats: true)
        status = true
    }
    
    func stopTimer() {
        
        timer?.invalidate()
        status = false
        
    }
    
    func resetTimer() {
        
        timer?.invalidate()

        status = false
        seconds = 30

        timerLabel.text = "00:30"
        
    }
    
    @IBAction func updateCounter() {
        if seconds < 1 {
            timer?.invalidate()
            var msg = String(format:"Your score was %02i.\n Click OK to play again.", gameScore!)
            if gameScore! > highScore {
                msg += "\nNEW HIGH SCORE: " + String(gameScore!)
            }
            let alert = UIAlertController(title: "Time's up!", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    self.restartGame()
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        } else {
            seconds -= 1
            let mins = Int(seconds) / 60 % 60
            let secs = Int(seconds) % 60
            timerLabel.text = String(format:"%02i:%02i", mins, secs)
        }
    }
    
    func play(move: Move) {
        guard let unwrappedGame = game else {
            print("Game is nil!")
            return
        }
        if !status {
            startTimer()
        }
        let response = unwrappedGame.play(move: move)
        if !response.right {
            stopTimer()
            var msg = "Time: " + timerLabel.text! + "\n" + "You lost the game! Click OK to play again."
            if gameScore! > highScore {
                msg += "\nNEW HIGH SCORE: " + String(gameScore!)
            }
            let alert = UIAlertController(title: "Wrong!", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    self.restartGame()
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
    
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        restartGame()
    }
    
    @IBAction func restartGame() {
        guard let unwrappedGame = game else {
            print("Game is nil!")
            return
        }
        resetTimer()
        guard let unwrappedScore = self.gameScore else {
            print("Score is nil!")
            return
        }
        if unwrappedScore > highScore {
            highScore = unwrappedScore
            highScoreLabel.text = NSString(format: "High Score: %i", highScore) as String
            
            let highScoreDefault = UserDefaults.standard
            highScoreDefault.setValue(highScore, forKey: "highScore")
            highScoreDefault.synchronize()
            
        }
        self.gameScore = 0
        unwrappedGame.restartGame()
        
    }
    
    
}


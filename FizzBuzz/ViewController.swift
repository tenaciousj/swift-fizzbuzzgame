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
//    var startTime: Double = 0
//    var time: Double = 0
//    var elapsed: Double = 0
    var seconds = 30
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
//        timerLabel.text = "00:00"
        
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
//        startTime = Date().timeIntervalSinceReferenceDate - elapsed
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//
//        // Set Start/Stop button to true
//        status = true
    }
    
    func stopTimer() {
        
        timer?.invalidate()
        status = false
//        elapsed = Date().timeIntervalSinceReferenceDate - startTime
//        timer?.invalidate()
//
//        // Set Start/Stop button to false
//        status = false
        
    }
    
    func resetTimer() {
        
        // Invalidate timer
        timer?.invalidate()

        // Reset timer variables
//        startTime = 0
//        time = 0
//        elapsed = 0
        status = false
        seconds = 30

        timerLabel.text = "00:30"
        
    }
    
    @IBAction func updateCounter() {
        if seconds < 1 {
            timer?.invalidate()
            let msg = String(format:"Your score was %02i.\n Click OK to play again.", gameScore!)
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
//        // Calculate total time since timer started in seconds
//        time = Date().timeIntervalSinceReferenceDate - startTime
//
//        // Calculate minutes
//        let minutes = UInt8(time / 60.0)
//        time -= (TimeInterval(minutes) * 60)
//
//        // Calculate seconds
//        let seconds = UInt8(time)
//        time -= TimeInterval(seconds)
//
//        // Format time vars with leading zero
//        let strMinutes = String(format: "%02d", minutes)
//        let strSeconds = String(format: "%02d", seconds)
//
//        timerLabel.text = strMinutes + ":" + strSeconds
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
            let msg = "Time: " + timerLabel.text! + "\n" + "You lost the game! Click OK to play again."
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


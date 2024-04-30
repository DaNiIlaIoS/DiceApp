//
//  ViewController.swift
//  DiceApp
//
//  Created by Zhangali Pernebayev on 04.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // Связка объектов с кодом
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var diceLabel: UILabel!
    @IBOutlet weak var diceButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var myScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    
    
    var timer: Timer?
    var countDown: Int = 30
    
    var myScore: Int = 0
    var computerScore: Int = 0
    
    let images = [
        UIImage(named: "dice-1"),
        UIImage(named: "dice-2"),
        UIImage(named: "dice-3"),
        UIImage(named: "dice-4"),
        UIImage(named: "dice-5"),
        UIImage(named: "dice-6")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Изменение объектов в коде
        
        // Изменение картинки image view
        diceImageView1.image = UIImage(named: "dice-1")
        diceImageView2.image = UIImage(named: "dice-4")
        
        // Изменение текста label
        diceLabel.text = "Кости"
        
        // Изменение цвета фона кнопки UIButton
        diceButton.backgroundColor = UIColor.black
        
        // Изменение текста в timerLabel
        timerLabel.text = "00:\(countDown)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scheduledTimer()
    }
    // Изменение картинки по нажатию на кнопку
    
    /*Многолинейные
     коментарии*/
    @IBAction func diceButtonTapped(_ sender: Any) {
        let myIndex = randomImageIndex()
        let computerIndex = randomImageIndex()
        
        print("User clicked the button")
        
        diceImageView1.image = images[myIndex]
        diceImageView2.image = images[computerIndex]
        
        let result = setWinner(computerIndex, myIndex)
        if result == "computerWins" {
            computerScore += 1
        } else if result == "playerWins" {
            myScore += 1
        }
        updateScores()
    }
    
    func randomImageIndex() -> Int {
        return Int.random(in: 0..<images.count)
    }
    
    func scheduledTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerUI), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerUI() {
        countDown -= 1
        
        if countDown >= 10 {
            timerLabel.text = "00:\(countDown)"
        } else {
            timerLabel.text = "00:0\(countDown)"
        }
        progressView.progress = Float(30 - countDown) / 30
        
        if countDown <= 0 {
            timer?.invalidate()
            printWinner()
        }
    }
    
    func updateScores() {
        myScoreLabel.text = String(myScore)
        computerScoreLabel.text = String(computerScore)
    }
    
    func setWinner(_ computerIndex: Int, _ myIndex: Int) -> String {
        if computerIndex == myIndex {
            return "draw"
        } else if myIndex > computerIndex {
            return "playerWins"
        } else {
            return "computerWins"
        }
    }
    
    func printWinner() {
        if myScore > computerScore {
            
            let alertController = UIAlertController(title: "Game Over", message: "I won", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
            
        } else if myScore < computerScore {
            
            let alertController = UIAlertController(title: "Game Over", message: "Computer won", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
            
        } else {
            
            let alertController = UIAlertController(title: "Game Over", message: "Draw", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }
    }
    
}


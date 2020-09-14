//
//  ViewController.swift
//  Bullseye2
//
//  Created by Tahlia Callegari on 9/3/20.
//  Copyright © 2020 Tahlia Callegari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 50
    var targetValue = 0
    var score = 0
    var round: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackerRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    @IBAction func startNewGame() {
        addHighScore(score)
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    func addHighScore(_ score: Int){
        //1
        guard score > 0 else {
            return;
        }
        //2
        let highscore = HighScoreItem()
        highscore.score = score
        highscore.name = "Unknown"
        
        //3
        var highScores = PersistencyHelper.loadHighScores()
        highScores.append(highscore)
        highScores.sort { $0.score > $1.score}
        PersistencyHelper.saveHighScores(highScores)
    }

    @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100 //Bonus points for getting bullseye
        }else if difference < 5{
            title = "Almost had it!"
            if difference == 1{
            points += 50 //Bonus points for missing by 1
            }
        }else if difference < 10{
            title = "Pretty good!"
        }else{
            title = "Not even close ...."
        }
        score += points
        
        //Alert message
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.startNewRound()})
        alert.addAction(action)
        
        //Make alert visible
        present(alert, animated: true, completion: nil)
    }
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)

    }
}

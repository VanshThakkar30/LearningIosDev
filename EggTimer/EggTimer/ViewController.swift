//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!

        override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    let eggTimer = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var totalTime = 0
    var counter = 0
    var timer = Timer()
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    @IBOutlet weak var LabelOfEgg: UILabel!
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimer[hardness]!
        
        counter = 0
        ProgressBar.progress = 0.0
        LabelOfEgg.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func update() {
        if counter < totalTime {
            
            counter += 1
            
            let percentProg = Float(counter)/Float(totalTime)
            ProgressBar.progress=percentProg
            
            
        } else {
            timer.invalidate()
            LabelOfEgg.text = "Done!"
            playSound()
            
        }
    }
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }
}

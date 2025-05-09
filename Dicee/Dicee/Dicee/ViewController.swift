//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    var leftImageNumber=0
    var rightImageNumber=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func rollPressed(_ sender: UIButton) {
        
        diceImageView1.image = [UIImage(named: "DiceOne"),UIImage(named: "DiceTwo"),UIImage(named: "DiceThree"),UIImage(named: "DiceFour"),UIImage(named: "DiceFive"),UIImage(named: "DiceSix")] [leftImageNumber]
        diceImageView2.image = [UIImage(named: "DiceOne"),UIImage(named: "DiceTwo"),UIImage(named: "DiceThree"),UIImage(named: "DiceFour"),UIImage(named: "DiceFive"),UIImage(named: "DiceSix")] [rightImageNumber]
        
        leftImageNumber = (leftImageNumber + Int.random(in: 0..<1000)) % 6
        rightImageNumber = (leftImageNumber + Int.random(in: 0..<1000)) % 6
        
    }
    
}


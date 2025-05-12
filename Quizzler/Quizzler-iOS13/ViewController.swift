//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    let quiz=[
        ["Two + Four is Equal to Six","True"],
        ["Eight - Five is Equal to Three","True"],
        ["Seven + One is Equal to Nine","False"]
    ]
    var questionNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        changeQuestion()
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        
        let answer = sender.currentTitle
        let correct = quiz[questionNumber][1]
        
        if answer == correct{
            print("Right")
        }
        else{
            print("Wrong")
        }
        
        if(questionNumber < quiz.count-1){
            questionNumber  += 1
        }
        else{
            questionNumber = 0
        }
        
        changeQuestion()
    }
    func changeQuestion(){
        questionLable.text = quiz[questionNumber][0]
    }
    
}


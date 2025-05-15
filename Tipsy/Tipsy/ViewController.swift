//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var splitCountLable: UILabel!
    @IBOutlet weak var billLable: UITextField!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    
    var buttonTitle: String = "10%"
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func ButtonPressed(_ sender: UIButton) {
        
        billLable.endEditing(true)
        
        zeroButton.isSelected = false
        tenButton.isSelected = false
        twentyButton.isSelected = false
        sender.isSelected = true
        
         buttonTitle = sender.currentTitle ?? "10%"
        
    }
    
    @IBAction func counterChanged(_ sender: UIStepper) {
        splitCountLable.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billLable.text ?? "0"
        let count = splitCountLable.text ?? "2"
        
        calculatorBrain.calculateTotal(buttonTitle: buttonTitle, Bill: bill,count: count)
        self.performSegue(withIdentifier: "toResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            
            if let destinationVC = segue.destination as? ResultViewController {
                
                destinationVC.result = calculatorBrain.getTotalBill()
                destinationVC.count = calculatorBrain.getCount()
                destinationVC.tip = calculatorBrain.getTip()
            }

            
        }
    }

}


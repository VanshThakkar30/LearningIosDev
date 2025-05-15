//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Jinfoappz on 14/05/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var infoText: UILabel!
    
    var result = "0.0"
    var tip = "10"
    var count = "2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBill.text = result
        let text = "Split between \(count) people, with \(tip)% tip."
        infoText.text = text

    }
    @IBAction func recalculatePressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

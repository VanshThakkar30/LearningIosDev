//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Jinfoappz on 14/05/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

struct CalculatorBrain {
    
    var bill: Double = 0.0
    var tip: Double = 0.10
    var count: Int = 2
    var totalBill: Double = 0.0
    
    mutating func calculateTotal(buttonTitle: String, Bill: String,count: String){
        
        let tipString = String(buttonTitle.dropLast()) // remove %
        tip = (Double(tipString) ?? 0.0) / 100

        bill = Double(Bill) ?? 0.0
        self.count = Int(count) ?? 2

        totalBill = (bill * (1 + tip)) / Double(self.count)
    }
    func getTotalBill() -> String{
        return String(format: "%.2f", totalBill)
    }
    func getCount() -> String{
        return String(count)
    }
    func getTip () -> String{
        return String(format: "%.0f", tip * 100)
    }
    
}

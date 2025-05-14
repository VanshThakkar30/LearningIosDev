//
//  calculatorBrain.swift
//  BMI Calculator
//
//  Created by Jinfoappz on 14/05/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    
    
    var bmi: BMI?
    
    func getBMI () -> String{
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    mutating func calculateBmi (height: Float,Weight: Float){
        
        let bmiValue = Weight / (height * height)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        }
        else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as fiddle!", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        }
        else{
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
    }
    
    func getAdvice () -> String{
        return bmi?.advice ?? "Eat some more Snacks"
    }
    
    func getColor () -> UIColor{
        return bmi?.color ?? #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    }
}

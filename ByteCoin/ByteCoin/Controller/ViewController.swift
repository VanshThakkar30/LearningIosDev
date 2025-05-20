//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var unitLable: UILabel!
    @IBOutlet weak var costLable: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
        coinManager.delegate = self
    }
}

//MARK: - UIPickerdataSource

extension ViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let  unit = coinManager.currencyArray[row]
        coinManager.featchExchangeRate(units: unit)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate{
    
    func didUpdateExchange(exchange: Double) {
        DispatchQueue.main.async{
            self.costLable.text = String(format: "%.2f", exchange)
            self.unitLable.text = self.coinManager.unit
        }
        
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
    
    
}

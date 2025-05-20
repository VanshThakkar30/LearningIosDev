//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateExchange(exchange: Double)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let url = "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms="
    
    //list of Curerency
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    //to store Json Data
    typealias ExchangeData = [String: Double]
    
    //delegate
    var delegate: CoinManagerDelegate?
    
    var unit: String?
    mutating func featchExchangeRate(units: String){
            let urlString = url + units
            unit = units
            performRequest(with: urlString)
        }
    
    func performRequest(with urlString: String){
        
        //1. Create url
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("error")
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let exchange = self.parseJSON(safeData){
                        self.delegate?.didUpdateExchange(exchange: exchange)
                    }
                }
            }
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ exchangeData: Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ExchangeData.self, from: exchangeData)
            let temp = decodedData[unit!]
            return temp
            
        } catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

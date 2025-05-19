//
//  WeatherData.swift
//  Clima
//
//  Created by Jinfoappz on 19/05/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable{
    
    let temp: Double
    let feels_like: Double
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}
struct Weather: Codable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}


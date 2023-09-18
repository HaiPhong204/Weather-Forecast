//
//  WindWeather.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import Foundation
struct WindWeatherModel: Codable {
    let speed: Double
    let deg: Int
    
    init(speed: Double, deg: Int) {
        self.speed = speed
        self.deg = deg
    }
}

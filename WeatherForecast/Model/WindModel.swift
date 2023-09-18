//
//  Wind.swift
//  WeatherForecast
//
//  Created by Windy on 11/09/2023.
//

import Foundation
struct WindModel: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    init(speed: Double, deg: Int, gust: Double) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

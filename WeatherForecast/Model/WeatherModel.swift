//
//  Weather.swift
//  WeatherForecast
//
//  Created by Windy on 11/09/2023.
//

import Foundation
struct WeatherModel: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

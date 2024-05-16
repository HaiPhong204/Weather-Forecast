//
//  City.swift
//  WeatherForecast
//
//  Created by Windy on 11/09/2023.
//

import Foundation
struct CityModel: Codable {
    let name: String
    let country: String
    
    init(name: String, country: String) {
        self.name = name
        self.country = country
    }
}

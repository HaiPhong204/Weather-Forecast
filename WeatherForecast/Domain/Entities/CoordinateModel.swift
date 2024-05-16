//
//  Coordinate.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import Foundation
struct CoordinateModel: Codable {
    let lon: Double
    let lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

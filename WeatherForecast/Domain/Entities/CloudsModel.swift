//
//  Cloud.swift
//  WeatherForecast
//
//  Created by Windy on 11/09/2023.
//

import Foundation
struct CloudsModel: Codable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
}

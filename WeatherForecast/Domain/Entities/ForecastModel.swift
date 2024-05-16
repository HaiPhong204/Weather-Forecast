//
//  Forecast.swift
//  WeatherForecast
//
//  Created by Windy on 10/09/2023.
//

import Foundation
struct ForecastModel : Codable {
    let city: CityModel
    let list: [WeatherInformationModel]
    
    init(city: CityModel, list: [WeatherInformationModel])
    {
        self.city = city
        self.list = list
    }
}

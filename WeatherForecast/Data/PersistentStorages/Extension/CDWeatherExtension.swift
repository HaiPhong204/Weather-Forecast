//
//  CDWeatherExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension WeatherCD {
    func convertToWeather() -> WeatherModel
    {
        return WeatherModel(id: Int(self.id), main: self.main, description: self.descriptions, icon: self.icon)
    }
}

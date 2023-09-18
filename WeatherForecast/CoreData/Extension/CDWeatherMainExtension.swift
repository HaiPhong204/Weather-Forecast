//
//  CDWeatherMainExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension WeatherMainCD
{
    func convertToWeatherMain() -> WeatherMainModel
    {
        return WeatherMainModel(temp: self.temp, feels_like: self.feels_like, temp_min: self.temp_min, temp_max: self.temp_max, pressure: Int(self.pressure), humidity: Int(self.humidity))
    }
}

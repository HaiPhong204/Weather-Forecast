//
//  CDWindWeatherExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension WindWeatherCD
{
    func convertToWindWeather() -> WindWeatherModel
    {
        return WindWeatherModel(speed: self.speed, deg: Int(self.deg))
    }
}

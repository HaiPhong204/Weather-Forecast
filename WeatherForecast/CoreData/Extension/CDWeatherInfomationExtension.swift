//
//  CDWeatherInfomationExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension WeatherInfomationCD
{
    func convertToWeatherInformation() -> WeatherInformationModel
    {
        return WeatherInformationModel(dt: Int(self.dt), main: self.main.convertToWeatherMain(), weather: self.convertToListWeather(), wind: self.wind.convertToWind(), clouds: self.clouds.convertToClouds(), visibility: Int(self.visibility), pop: self.pop, dt_txt: self.dt_txt)
    }
    
    private func convertToListWeather() -> [WeatherModel]
    {
        var list: [WeatherModel] = []

        self.weather.forEach({ (value) in
            list.append(value.convertToWeather())
        })

        return list
    }
}

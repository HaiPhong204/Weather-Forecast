//
//  CDWeatherLocationExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension WeatherLocationCD
{
    func convertToWeatherLocation() -> WeatherLocationModel
    {
        return WeatherLocationModel(coord: self.coord.convertToCoordinate(), weather: self.convertToListWeather(), base: self.base, main: self.main.convertToWeatherMain(), visibility: Int(self.visibility), wind: self.wind.convertToWindWeather(), clouds: self.clouds.convertToClouds(), dt: Int(self.dt), sys: self.sys.convertToSystem(), timezone: Int(self.timezone), id: Int(self.id), name: self.name, cod: Int(self.cod))
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

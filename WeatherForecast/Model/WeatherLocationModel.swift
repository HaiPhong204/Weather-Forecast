//
//  WeatherLocation.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import Foundation
struct WeatherLocationModel : Codable {
    let coord: CoordinateModel
    let weather: [WeatherModel]
    let base: String
    let main: WeatherMainModel
    let visibility: Int
    let wind: WindWeatherModel
    let clouds: CloudsModel
    let dt: Int
    let sys: SystemModel
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    init(coord: CoordinateModel, weather: [WeatherModel], base: String, main: WeatherMainModel, visibility: Int, wind: WindWeatherModel, clouds: CloudsModel, dt: Int, sys: SystemModel, timezone: Int, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
}

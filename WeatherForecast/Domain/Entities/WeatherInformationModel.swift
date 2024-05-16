//
//  Weather.swift
//  WeatherForecast
//
//  Created by Windy on 10/09/2023.
//

import Foundation
struct WeatherInformationModel : Codable {
    let dt: Int
    let main: WeatherMainModel
    let weather: [WeatherModel]
    let wind: WindModel
    let clouds: CloudsModel
    let visibility: Int
    let pop: Double
    let dt_txt: String
    
    init(dt: Int, main: WeatherMainModel, weather: [WeatherModel], wind: WindModel, clouds: CloudsModel, visibility: Int, pop: Double, dt_txt: String) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.wind = wind
        self.clouds = clouds
        self.visibility = visibility
        self.pop = pop
        self.dt_txt = dt_txt
    }
}

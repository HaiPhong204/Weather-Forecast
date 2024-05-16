//
//  CDCityExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension CityCD
{
    func convertToCity() -> CityModel
    {
        return CityModel(name: self.name, country: self.country)
    }
}

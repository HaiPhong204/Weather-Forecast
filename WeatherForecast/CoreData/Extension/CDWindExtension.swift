//
//  CDWindExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension WindCD
{
    func convertToWind() -> WindModel
    {
        return WindModel(speed: self.speed, deg: Int(self.deg), gust: self.gust)
    }
}

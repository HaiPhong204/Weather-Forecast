//
//  CDSystemExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension SystemCD
{
    func convertToSystem() -> SystemModel
    {
        return SystemModel(type: Int(self.type), id: Int(self.id), country: self.country, sunrise: Int(self.sunrise), sunset: Int(self.sunset))
    }
}

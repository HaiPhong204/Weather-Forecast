//
//  CDCloudsExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension CloudsCD
{
    func convertToClouds() -> CloudsModel
    {
        return CloudsModel(all: Int(self.all))
    }
}

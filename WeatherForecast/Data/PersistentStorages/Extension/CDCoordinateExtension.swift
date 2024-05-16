//
//  CDCoordinateExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension CoordinateCD
{
    func convertToCoordinate() -> CoordinateModel
    {
        return CoordinateModel(lon: self.lon, lat: self.lat)
    }
}

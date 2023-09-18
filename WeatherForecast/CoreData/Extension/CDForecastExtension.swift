//
//  CDForecastExtension.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
extension ForecastCD {
    func convertToForecastModel() -> ForecastModel
    {
        return ForecastModel(city: self.city.convertToCity(), list: self.convertToList())
    }

    private func convertToList() -> [WeatherInformationModel]
    {
        var list: [WeatherInformationModel] = []

        self.list.forEach({ (value) in
            list.append(value.convertToWeatherInformation())
        })

        return list
    }
}

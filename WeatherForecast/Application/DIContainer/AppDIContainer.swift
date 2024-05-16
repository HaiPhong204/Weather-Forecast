//
//  AppDIContainer.swift
//  WeatherForecast
//
//  Created by Windy on 14/5/24.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: "abc")!
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    // MARK: - DIContainers of scenes
    func makeWeatherForecastSceneDIContainer() -> WeatherForecastDIContainer {
        let dependencies = WeatherForecastDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return WeatherForecastDIContainer(dependencies: dependencies)
    }
}

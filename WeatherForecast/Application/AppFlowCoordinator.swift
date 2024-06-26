//
//  AppFlowCoordinator.swift
//  WeatherForecast
//
//  Created by Windy on 14/5/24.
//
import Foundation
import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let weatherForecastSceneDIContainer = appDIContainer.makeWeatherForecastSceneDIContainer()
        let flow = weatherForecastSceneDIContainer.makeWeatherFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

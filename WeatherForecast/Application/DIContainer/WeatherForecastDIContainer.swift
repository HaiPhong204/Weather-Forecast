//
//  WeatherForecastDIContainer.swift
//  WeatherForecast
//
//  Created by Windy on 14/5/24.
//

import UIKit
import SwiftUI

final class WeatherForecastDIContainer: WeatherForecastFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchWeatherUseCase() -> SearchWeatherLocationUseCase {
        DefaultSearchWeatherLocationUseCase(weatherLocationsRepository: makeWeatherLocationRepository())
    }

    // MARK: - Repositories
    func makeWeatherLocationRepository() -> WeatherLocationsRepository {
        DefaultWeatherLocationsRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - MapView
    func makeMapViewController(actions: MapViewModelActions) -> MapViewController {
        return MapViewController.create(with: makeMapViewModel(actions: actions))
    }

    func makeMapViewModel(actions: MapViewModelActions) -> MapViewModel {
        MapViewModel(actions: actions, searchWeatherLocationUseCase: makeSearchWeatherUseCase())
    }
    // MARK: - Movie Details
   
    // MARK: - Movies Queries Suggestions List

    // MARK: - Flow Coordinators
    func makeWeatherFlowCoordinator(navigationController: UINavigationController) -> WeatherForecastFlowCoordinator {
        WeatherForecastFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

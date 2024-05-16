//
//  WeatherForecastFlowCoordinator.swift
//  WeatherForecast
//
//  Created by Windy on 14/5/24.
//
import UIKit

protocol WeatherForecastFlowCoordinatorDependencies  {
    func makeMapViewController(
        actions: MapViewModelActions
    ) -> MapViewController
}

final class WeatherForecastFlowCoordinator {

    private let navigationController: UINavigationController
    private let dependencies: WeatherForecastFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies: WeatherForecastFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = MapViewModelActions()
        let mapViewController = dependencies.makeMapViewController(actions: actions)
        navigationController.pushViewController(mapViewController, animated: false)
    }
}

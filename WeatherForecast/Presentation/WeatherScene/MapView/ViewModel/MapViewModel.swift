//
//  MapViewModel.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import Foundation
import UIKit

//Navigation on ViewModel
struct MapViewModelActions {}

protocol WeatherServiceProtocol {
    func getIconImage(icon: String) async -> UIImage?
    func didSearch(query: String) async
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var errorTitle: String { get }
}

final class MapViewModel: WeatherServiceProtocol {
    
    var weatherLocation: WeatherLocationModel?
    private let actions: MapViewModelActions?
    private let searchWeatherLocationUseCase: SearchWeatherLocationUseCase
    private let mainQueue: DispatchQueueType
    
    let apiService = APIService.share
    
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    private var weatherLoadTask: Cancellable? { willSet { weatherLoadTask?.cancel() } }
    
    init(
        actions: MapViewModelActions? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main,
        searchWeatherLocationUseCase: SearchWeatherLocationUseCase
    ) {
        self.actions = actions
        self.searchWeatherLocationUseCase = searchWeatherLocationUseCase
        self.mainQueue = mainQueue
    }
    
    
    private func load(weatherLocationQuery: WeatherLocationQuery) async {
        query.value = weatherLocationQuery.query
        self.weatherLocation = await searchWeatherLocationUseCase.getWeatherDataRepo(requestValue: .init(query: weatherLocationQuery))
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }
    
    private func update(weatherLocationQuery: WeatherLocationQuery) async {
        await load(weatherLocationQuery: weatherLocationQuery)
    }
    
    func didSearch(query: String) async {
        guard !query.isEmpty else { return }
        await update(weatherLocationQuery: WeatherLocationQuery(query: query))
    }
    
    func getIconImage(icon: String) async -> UIImage? {
        let imgURLString = "https://openweathermap.org/img/w/\(icon).png"
        guard let imageURL = URL(string: imgURLString) else {
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            guard let image = UIImage(data: data) else {
                return nil
            }
            return image
        } catch {
            // Xử lý lỗi
            return nil
        }
    }
}

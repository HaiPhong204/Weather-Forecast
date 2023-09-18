//
//  MapViewModel.swift
//  WeatherForecast
//
//  Created by Windy on 12/09/2023.
//

import Foundation
import UIKit

struct MapViewModel {
    
    var weatherLocation: WeatherLocationModel?
    let apiService = APIService.share
    
    func getWeatherData(city: String) async -> WeatherLocationModel? {
        do {
            let weather: WeatherLocationModel = try await withCheckedThrowingContinuation { continuation in
                apiService.getJson(url: "\(Network.weatherDataUrl)q=\(city)&appid=\(Network.APIkey)&units=metric", dateDecodingStrategy: .secondsSince1970) { (result: Result<WeatherLocationModel, APIService.APIError>) in
                    switch result {
                    case .success(let _weather):
                        continuation.resume(returning: _weather)
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                            continuation.resume(throwing: apiError)
                        }
                    }
                }
            }
            return weather
        } catch {
            // Xử lý lỗi
            return nil
        }
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

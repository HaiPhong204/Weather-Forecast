//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by Windy on 14/09/2023.
//

import Foundation
import UIKit

struct WeatherDetailViewModel {
    
    var foreacast: ForecastModel?
    let apiService = APIService.share
    
    func getForecastData(city: String) async -> ForecastModel? {
        do {
            let data: ForecastModel = try await withCheckedThrowingContinuation { continuation in
                apiService.getJson(url: "\(Network.weatherForecastUrl)q=\(city)&appid=\(Network.APIkey)&units=metric", dateDecodingStrategy: .secondsSince1970) { (result: Result<ForecastModel, APIService.APIError>) in
                    switch result {
                    case .success(let _forecast):
                        continuation.resume(returning: _forecast)
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                            continuation.resume(throwing: apiError)
                        }
                    }
                }
            }
            return data
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

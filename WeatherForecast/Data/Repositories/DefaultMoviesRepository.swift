// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

final class DefaultWeatherLocationsRepository {

    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    private let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    private let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    let apiService = APIService.share
    
    init(
        dataTransferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated),
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
        self.dateDecodingStrategy = dateDecodingStrategy
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}

extension DefaultWeatherLocationsRepository: WeatherLocationsRepository {

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
    
    func fetchWeatherList(
        query: WeatherLocationQuery,
        completion: @escaping (Result<WeatherLocationModel, Error>) -> Void
    ) -> Cancellable? {
        guard let url = URL(string: "\(Network.weatherDataUrl)q=\(query.query)&appid=\(Network.APIkey)&units=metric") else {
            completion(.failure(URLError(.badURL)))
            return nil
        }
        
        print("URL: \(url)") // In ra URL để kiểm tra

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)") // In ra lỗi nếu có
                completion(.failure(error))
                return
            }
            
            if let error = error {
                print("error")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)") // In ra mã trạng thái của phản hồi
            }
            
            guard let data = data else {
                print("No data received") // In ra thông báo khi không có dữ liệu nhận được
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Data cannot be decoded as UTF-8")") // In ra dữ liệu nhận được
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .deferredToDate
            decoder.keyDecodingStrategy = .useDefaultKeys
            
            do {
                let decodedData = try decoder.decode(WeatherLocationModel.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                print("Decoding error: \(decodingError)") // In ra lỗi giải mã nếu có
                completion(.failure(decodingError))
            }
        }.resume()
        
        return RepositoryTask()
    }
}

import Foundation

protocol SearchWeatherLocationUseCase {
    func execute(
        requestValue: SearchWeatherUseCaseRequestValue,
        completion: @escaping (Result<WeatherLocationModel, Error>) -> Void
    ) -> Cancellable?
    
    func getWeatherDataRepo(
        requestValue: SearchWeatherUseCaseRequestValue) async
    -> WeatherLocationModel?
}

final class DefaultSearchWeatherLocationUseCase: SearchWeatherLocationUseCase {

    private let weatherLocationsRepository: WeatherLocationsRepository

    init(
        weatherLocationsRepository: WeatherLocationsRepository
    ) {

        self.weatherLocationsRepository = weatherLocationsRepository
    }

    func execute(
        requestValue: SearchWeatherUseCaseRequestValue,
        completion: @escaping (Result<WeatherLocationModel, Error>) -> Void
    ) -> Cancellable? {

        return weatherLocationsRepository.fetchWeatherList(
            query: requestValue.query,
            completion: { result in
            completion(result)
        })
    }
    
    func getWeatherDataRepo(
        requestValue: SearchWeatherUseCaseRequestValue) async
    -> WeatherLocationModel? {
        return await weatherLocationsRepository.getWeatherData(city: requestValue.query.query)
    }
}

struct SearchWeatherUseCaseRequestValue {
    let query: WeatherLocationQuery
}

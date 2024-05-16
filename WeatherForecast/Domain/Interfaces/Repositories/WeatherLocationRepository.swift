import Foundation

protocol WeatherLocationsRepository{
    @discardableResult
    func fetchWeatherList(
        query: WeatherLocationQuery,
        completion: @escaping (Result<WeatherLocationModel, Error>) -> Void
    ) -> Cancellable?
    
    func getWeatherData(city: String) async -> WeatherLocationModel?
    
//    func deleteAllData()
//    func delete(entityName: String)
//    func create(record: WeatherLocationModel)
//    func getWeatherLocation() -> WeatherLocationModel?
}

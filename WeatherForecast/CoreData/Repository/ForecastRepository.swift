//
//  ForecastRepository.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation
import CoreData

/* Hey there, this is Ravi, I hope this video was helpful to you and provided all the right set of information to get you started with one to Many relationship in coredata.

 If you have any questions then please feel free to ask them as commnets or you can ask them to me via email. My email id is codecat15@gmail.com

 Please do support the channel by sharing it with you iOS group or class on Facebook or WhatsApp.

 Regards,
 Ravi (CodeCat15)

 */

struct ForecastRepository : BaseRepository {
    
    func deleteAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ForecastCD")
        let DelAll = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do { try PersistentStorage.shared.context.execute(DelAll) }
        catch { print(error) }
    }

    func create(record: ForecastModel) {
        let cdForecast = ForecastCD(context: PersistentStorage.shared.context)
        
        //add City
        cdForecast.city.name = record.city.name
        cdForecast.city.country = record.city.country
        //
        
        //add [WeatherInfomation]
        var weatherInfomationSet = Set<WeatherInfomationCD>()
        record.list.forEach({ (weatherInfomation) in

            let cdWeatherInfomation = WeatherInfomationCD(context: PersistentStorage.shared.context)
            cdWeatherInfomation.dt = Int32(weatherInfomation.dt)
            
            var weatherSet = Set<WeatherCD>()
            weatherInfomation.weather.forEach({ (weather) in
                let cdWeather = WeatherCD(context: PersistentStorage.shared.context)
                cdWeather.icon = weather.icon
                cdWeather.id = Int32(weather.id)
                cdWeather.descriptions = weather.description
                cdWeather.main = weather.main
                
                weatherSet.insert(cdWeather)
            })
            cdWeatherInfomation.weather = weatherSet
            
            //add WeatherMain
            let cdWeatherMain = WeatherMainCD(context: PersistentStorage.shared.context)
            cdWeatherMain.temp = weatherInfomation.main.temp
            cdWeatherMain.temp_min = weatherInfomation.main.temp_min
            cdWeatherMain.temp_max = weatherInfomation.main.temp_max
            cdWeatherMain.feels_like = weatherInfomation.main.feels_like
            cdWeatherMain.humidity = Int32(weatherInfomation.main.humidity)
            cdWeatherMain.pressure = Int32(weatherInfomation.main.pressure)
            cdWeatherInfomation.main = cdWeatherMain
            //
            
            //convert Wind
            let cdWind = WindCD(context: PersistentStorage.shared.context)
            cdWind.deg = Int32(weatherInfomation.wind.deg)
            cdWind.gust = weatherInfomation.wind.gust
            cdWind.speed = weatherInfomation.wind.speed
            cdWeatherInfomation.wind = cdWind
            //
            
            //convert Clouds
            let cdClouds = CloudsCD(context: PersistentStorage.shared.context)
            cdClouds.all = Int32(weatherInfomation.clouds.all)
            cdWeatherInfomation.clouds = cdClouds
            //
            
            cdWeatherInfomation.visibility = Int32(weatherInfomation.visibility)
            cdWeatherInfomation.pop = weatherInfomation.pop
            cdWeatherInfomation.dt_txt = weatherInfomation.dt_txt

            weatherInfomationSet.insert(cdWeatherInfomation)
        })
        
        cdForecast.list = weatherInfomationSet

        PersistentStorage.shared.saveContext()

    }

    func getForecast() -> ForecastModel? {

        let records = PersistentStorage.shared.fetchManagedObject(managedObject: ForecastCD.self)
        guard records != nil && records?.count != 0 else {return nil}
        
        return records!.first?.convertToForecastModel()
    }
}

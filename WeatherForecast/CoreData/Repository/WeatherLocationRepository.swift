//
//  WeatherLocationRepository.swift
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

struct WeatherLocationRepository : BaseRepository {
    
    func deleteAllData(){
        let entities = PersistentStorage.shared.persistentContainer.managedObjectModel.entities
            for entity in entities {
                delete(entityName: entity.name!)
            }
    }
    
    func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let DelAll = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do { try PersistentStorage.shared.context.execute(DelAll) }
        catch { print(error) }
    }

    

    func create(record: WeatherLocationModel) {

        let cdWeatherLocation = WeatherLocationCD(context: PersistentStorage.shared.context)
        
        cdWeatherLocation.dt = Int32(record.dt)
        cdWeatherLocation.visibility = Int32(record.visibility)
        cdWeatherLocation.base = record.base
        cdWeatherLocation.timezone = Int32(record.timezone)
        cdWeatherLocation.name = record.name
        cdWeatherLocation.cod = Int32(record.cod)
        cdWeatherLocation.id = Int32(record.id)
        
        //covert CoordinateModel
        let cdCoordinate = CoordinateCD(context: PersistentStorage.shared.context)
        cdCoordinate.lat = record.coord.lat
        cdCoordinate.lon = record.coord.lon
        cdWeatherLocation.coord = cdCoordinate
        //
        
        //covert [WeatherModel]
        var weatherSet = Set<WeatherCD>()
        record.weather.forEach({ (weather) in

            let cdWeather = WeatherCD(context: PersistentStorage.shared.context)
            cdWeather.icon = weather.icon
            cdWeather.id = Int32(weather.id)
            cdWeather.descriptions = weather.description
            cdWeather.main = weather.main
            
            weatherSet.insert(cdWeather)
        })
        cdWeatherLocation.weather = weatherSet
        
        //convert WeatherMainCD
        let cdWeatherMain = WeatherMainCD(context: PersistentStorage.shared.context)
        cdWeatherMain.temp = record.main.temp
        cdWeatherMain.temp_min = record.main.temp_min
        cdWeatherMain.temp_max = record.main.temp_max
        cdWeatherMain.feels_like = record.main.feels_like
        cdWeatherMain.humidity = Int32(record.main.humidity)
        cdWeatherMain.pressure = Int32(record.main.pressure)
        
        cdWeatherLocation.main = cdWeatherMain
        //
        
        //convert WindCD
        let cdWindWeather = WindWeatherCD(context: PersistentStorage.shared.context)
        cdWindWeather.deg = Int32(record.wind.deg)
        cdWindWeather.speed = record.wind.speed
        
        cdWeatherLocation.wind = cdWindWeather
        //
        
        //convert CloudsCD
        let cdClouds = CloudsCD(context: PersistentStorage.shared.context)
        cdClouds.all = Int32(record.clouds.all)
        
        cdWeatherLocation.clouds = cdClouds
        //
        
        //convert SystemCD
        let cdSystem = SystemCD(context: PersistentStorage.shared.context)
        cdSystem.type = Int32(record.sys.type)
        cdSystem.id = Int32(record.sys.id)
        cdSystem.country = record.sys.country
        cdSystem.sunrise = Int32(record.sys.sunrise)
        cdSystem.sunset = Int32(record.sys.sunset)
        
        cdWeatherLocation.sys = cdSystem
        //
        
        cdWeatherLocation.timezone = Int32(record.timezone)
        cdWeatherLocation.id = Int32(record.id)
        cdWeatherLocation.name = record.name
        cdWeatherLocation.cod = Int32(record.cod)

        PersistentStorage.shared.saveContext()

    }

    func getWeatherLocation() -> WeatherLocationModel? {

        let records = PersistentStorage.shared.fetchManagedObject(managedObject: WeatherLocationCD.self)
        guard records != nil && records?.count != 0 else {return nil}
        
        return records!.first?.convertToWeatherLocation()
    }
}

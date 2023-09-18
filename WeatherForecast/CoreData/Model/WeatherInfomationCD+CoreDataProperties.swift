//
//  WeatherInfomationCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension WeatherInfomationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInfomationCD> {
        return NSFetchRequest<WeatherInfomationCD>(entityName: "WeatherInfomationCD")
    }

    @NSManaged public var dt: Int32
    @NSManaged public var pop: Double
    @NSManaged public var visibility: Int32
    @NSManaged public var dt_txt: String
    @NSManaged public var wind: WindCD
    @NSManaged public var clouds: CloudsCD
    @NSManaged public var main: WeatherMainCD
    @NSManaged public var weather: Set<WeatherCD>
    @NSManaged public var toForecast: ForecastCD

}

// MARK: Generated accessors for weather
extension WeatherInfomationCD {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherCD)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherCD)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension WeatherInfomationCD : Identifiable {

}

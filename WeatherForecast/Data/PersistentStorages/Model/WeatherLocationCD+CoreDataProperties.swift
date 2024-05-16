//
//  WeatherLocationCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension WeatherLocationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherLocationCD> {
        return NSFetchRequest<WeatherLocationCD>(entityName: "WeatherLocationCD")
    }

    @NSManaged public var base: String
    @NSManaged public var visibility: Int32
    @NSManaged public var dt: Int32
    @NSManaged public var timezone: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var cod: Int32
    @NSManaged public var coord: CoordinateCD
    @NSManaged public var weather: Set<WeatherCD>
    @NSManaged public var main: WeatherMainCD
    @NSManaged public var wind: WindWeatherCD
    @NSManaged public var clouds: CloudsCD
    @NSManaged public var sys: SystemCD

}

// MARK: Generated accessors for weather
extension WeatherLocationCD {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherCD)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherCD)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension WeatherLocationCD : Identifiable {

}

//
//  WeatherMainCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension WeatherMainCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherMainCD> {
        return NSFetchRequest<WeatherMainCD>(entityName: "WeatherMainCD")
    }

    @NSManaged public var temp: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var feels_like: Double
    @NSManaged public var pressure: Int32
    @NSManaged public var humidity: Int32
    @NSManaged public var toWeatherLocation: WeatherLocationCD
    @NSManaged public var toWeatherInfomation: WeatherInfomationCD

}

extension WeatherMainCD : Identifiable {

}

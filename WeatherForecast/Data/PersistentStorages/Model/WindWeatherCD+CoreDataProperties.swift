//
//  WindWeatherCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension WindWeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindWeatherCD> {
        return NSFetchRequest<WindWeatherCD>(entityName: "WindWeatherCD")
    }

    @NSManaged public var deg: Int32
    @NSManaged public var speed: Double
    @NSManaged public var toWeatherLocation: WeatherLocationCD

}

extension WindWeatherCD : Identifiable {

}

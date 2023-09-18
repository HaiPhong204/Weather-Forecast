//
//  WeatherCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension WeatherCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherCD> {
        return NSFetchRequest<WeatherCD>(entityName: "WeatherCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var main: String
    @NSManaged public var descriptions: String
    @NSManaged public var icon: String
    @NSManaged public var toWeatherLocation: WeatherLocationCD
    @NSManaged public var toWeatherInfomation: WeatherInfomationCD

}

extension WeatherCD : Identifiable {

}

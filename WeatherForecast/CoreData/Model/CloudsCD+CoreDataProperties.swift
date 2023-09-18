//
//  CloudsCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension CloudsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CloudsCD> {
        return NSFetchRequest<CloudsCD>(entityName: "CloudsCD")
    }

    @NSManaged public var all: Int32
    @NSManaged public var toWeatherLocation: WeatherLocationCD
    @NSManaged public var toWeatherInfomation: WeatherInfomationCD

}

extension CloudsCD : Identifiable {

}

//
//  SystemCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension SystemCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SystemCD> {
        return NSFetchRequest<SystemCD>(entityName: "SystemCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var type: Int32
    @NSManaged public var country: String
    @NSManaged public var sunrise: Int32
    @NSManaged public var sunset: Int32
    @NSManaged public var toWeatherLocation: WeatherLocationCD

}

extension SystemCD : Identifiable {

}

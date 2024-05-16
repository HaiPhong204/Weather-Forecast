//
//  CoordinateCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension CoordinateCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordinateCD> {
        return NSFetchRequest<CoordinateCD>(entityName: "CoordinateCD")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var toWeatherLocation: WeatherLocationCD

}

extension CoordinateCD : Identifiable {

}

//
//  CityCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension CityCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityCD> {
        return NSFetchRequest<CityCD>(entityName: "CityCD")
    }

    @NSManaged public var name: String
    @NSManaged public var country: String
    @NSManaged public var list: ForecastCD

}

extension CityCD : Identifiable {

}

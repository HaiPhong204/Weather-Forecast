//
//  ForecastCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension ForecastCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastCD> {
        return NSFetchRequest<ForecastCD>(entityName: "ForecastCD")
    }

    @NSManaged public var city: CityCD
    @NSManaged public var list: Set<WeatherInfomationCD>

}

// MARK: Generated accessors for list
extension ForecastCD {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: WeatherInfomationCD)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: WeatherInfomationCD)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension ForecastCD : Identifiable {

}

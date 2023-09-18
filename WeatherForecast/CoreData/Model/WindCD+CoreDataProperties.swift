//
//  WindCD+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//
//

import Foundation
import CoreData


extension WindCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindCD> {
        return NSFetchRequest<WindCD>(entityName: "WindCD")
    }

    @NSManaged public var speed: Double
    @NSManaged public var deg: Int32
    @NSManaged public var gust: Double
    @NSManaged public var toWeatherInfomation: WeatherInfomationCD

}

extension WindCD : Identifiable {

}

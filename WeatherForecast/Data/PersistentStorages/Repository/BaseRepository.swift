//
//  BaseRepository.swift
//  WeatherForecast
//
//  Created by Windy on 17/09/2023.
//

import Foundation

protocol BaseRepository {
    associatedtype T
    
    func create(record: T)
}

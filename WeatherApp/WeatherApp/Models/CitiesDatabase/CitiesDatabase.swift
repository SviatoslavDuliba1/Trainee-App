//
//  CitiesDatabase.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 18.08.2022.
//

import Foundation
import RealmSwift

// MARK: - CitiesDatabase
class CitiesDatabase: Object {
    @objc dynamic var name: String?
    @objc dynamic var country: String?
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var timeZoneOfSet: Int = 0
    @objc dynamic var temperature: Double = 0.0
    @objc dynamic var weatherDescription: String?
    @objc dynamic var lowTemperature: Double = 0.0
    @objc dynamic var HightTemperature: Double = 0.0
}

//
//  Temp.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 12.07.2022.
//

import Foundation

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

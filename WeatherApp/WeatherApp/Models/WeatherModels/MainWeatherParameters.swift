//
//  MainWeatherParameters.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 12.07.2022.
//

import Foundation

// MARK: - MainWeatherParameters
struct MainWeatherParameters: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hourly: [CurrentWeather]
    let daily: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly, daily
    }
}

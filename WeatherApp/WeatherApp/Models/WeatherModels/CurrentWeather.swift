//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 12.07.2022.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [WeatherParameters]
    let pop: Double?
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case pop
        case rain
    }
}

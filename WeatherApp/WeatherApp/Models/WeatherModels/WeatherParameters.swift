//
//  WeatherParameters.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 12.07.2022.
//

import Foundation

// MARK: - WeatherParameters
struct WeatherParameters: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon = "icon"
    }
}

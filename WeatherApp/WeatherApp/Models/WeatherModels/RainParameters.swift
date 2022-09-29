//
//  Rain.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 12.07.2022.
//

import Foundation

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

//
//  ParametersOfCity.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import Foundation

//MARK: - ParametersOfCity
struct ParametersOfCity: Codable {
    let id: Int?
    let name, state, country: String
    let coord: CityCoord
}

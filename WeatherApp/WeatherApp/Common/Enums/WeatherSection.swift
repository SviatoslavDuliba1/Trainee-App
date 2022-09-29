//
//  WeatherSection.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Foundation

//MARK: - WeatherSection
enum WeatherSection: Int, CaseIterable {
    case DayWeatherPerHour
    case TenDaysWeather
    case UviAndSunset
    case WindAndPrecipitation
    case FeelsLikeAndHumidity
    case VisibilityAndPresure
}

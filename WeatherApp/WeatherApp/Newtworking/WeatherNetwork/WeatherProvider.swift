//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Foundation
import Moya
import CoreLocation

//MARK: - WeatherProvider
enum WeatherProvider {
    case currentLocationWeather(longitude: Double, latitude: Double)
//    case weatherBySelectedCity(city: String)
}

//MARK: - Properties
extension WeatherProvider: TargetType {
    var headers: [String : String]? {
        let parameters: [String: String] = [:]
        return parameters
    }
    
    var baseURL: URL {
        return  URL(string: "https://api.openweathermap.org/data/2.5/onecall?&appid=0f158f76db5b186912f2139b8612082c")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let.currentLocationWeather(longitude, latitude):
            let parameters: [String: Any] = [
                "lon": longitude,
                "lat": latitude,
                "units": "metric",
                "lang": "en"
            ]
            return.requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
//        case let.weatherBySelectedCity(city):
//            let parameters: [String: Any] = [
//                "q": city,
//                "units": "metric",
//                "lang": "en"
//            ]
//            return.requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}

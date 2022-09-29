//
//  WeatherProject.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Moya

//MARK: - WeatherProject
struct WeatherProject {
    
    //MARK: - Properties
    static let shared = WeatherProject()
    let network: WeatherNetwork
    
    private init() {
        let config = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let loggerPlugin = NetworkLoggerPlugin(configuration: config)
        let converter = JSONDataConverterService()
        
        network = WeatherNetwork(
            converter: converter,
            plugins: [loggerPlugin], interceptor: EnvironmentInterceptor())
    }
}

//
//  WeatherNetwork.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Foundation
import Moya
import PromiseKit

//MARK: - WeatherNetwork
final class WeatherNetwork: Networkable {
    
    //MARK: - Properties
    let provider: MoyaProvider<WeatherProvider>
    let dataConverter: JSONDataConverterService
    
    init(converter: JSONDataConverterService,
         plugins: [PluginType],
         interceptor: EnvironmentInterceptor = EnvironmentInterceptor()) {
        self.dataConverter = converter
        let session = Session(startRequestsImmediately: false, interceptor: interceptor)
        let provider = MoyaProvider<WeatherProvider>(session: session, plugins: plugins)
        self.provider = provider
    }
    
    //MARK: - Methods
    func currentLocationWeather(longitude: Double, latitude: Double) -> Promise<MainWeatherParameters> {
        return executeAndMap(request: .currentLocationWeather(longitude: longitude, latitude: latitude))
    }
    
//    func weatherBySelectedCity(city: String) ->
//    Promise<MainWeatherParameters> {
//        return executeAndMap(request: .weatherBySelectedCity(city: city))
//    }
}

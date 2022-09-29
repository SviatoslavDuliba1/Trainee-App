//
//  Router.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Foundation
import UIKit

//MARK: - Router
class Router {
    
    //MARK: - Public functions
    func start(window: UIWindow?) {
        displayCurrentWeather(window: window)
    }
    
    //MARK: - Private functions
    private func displayCurrentWeather(window: UIWindow?) {
        guard let vc = UIStoryboard( name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "MainNavigationController") as? WeatherViewController else { return }
        vc.presenter = WeatherViewPresenter(view: vc, cityName: nil, countryName: nil, longitude: nil, latitude: nil)
        let navigationViewController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationViewController
    }
}

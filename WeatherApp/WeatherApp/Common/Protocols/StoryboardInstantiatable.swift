//
//  StoryboardInstantiatable.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit

//MARK: - StoryboardInstantiatable
protocol StoryboardInstantiatable {}

extension StoryboardInstantiatable where Self: NibRepresentable {
    
    //MARK: - Static Methods
    static func instantiateFromStoryboard(name: String = Self.identifier) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Self.identifier)
        return viewController as! Self
    }
    
    static func instantiateLaunchScreen() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: Self.identifier)
        return viewController as! Self
    }
}

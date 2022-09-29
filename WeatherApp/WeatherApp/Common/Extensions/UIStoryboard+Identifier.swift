//
//  UIStoryboard+Identifier.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit

//MARK: - UIStoryboard+Identifier
extension UIStoryboard {
    var identifier: String {
        return String(describing: self)
    }
}

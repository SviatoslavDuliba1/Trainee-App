//
//  ViewControllerRepresentable.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit

//MARK: - ViewControllerRepresentable
protocol ViewControllerRepresentable: AnyObject {
    var view: UIView! { get }
}

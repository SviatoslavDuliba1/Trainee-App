//
//  NibRepresentable.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit

//MARK: - NibRepresentable
protocol NibRepresentable {
    
    //MARK: - Static Properties
    static var nib: UINib { get }
    static var identifier: String { get }
}

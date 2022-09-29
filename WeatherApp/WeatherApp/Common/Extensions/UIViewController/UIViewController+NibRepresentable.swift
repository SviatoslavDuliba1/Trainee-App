//
//  UIViewController+NibRepresentable.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit

//MARK: - UIViewController+NibRepresentable
extension UIViewController: NibRepresentable {
    
    //MARK: - Properties
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    class var identifier: String {
        return String(describing: self)
    }
}

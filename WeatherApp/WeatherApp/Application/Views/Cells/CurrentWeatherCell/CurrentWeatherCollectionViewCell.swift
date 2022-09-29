//
//  CurrentWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 15.07.2022.
//

import UIKit
import CoreLocation

//MARK: - CurrentWeatherCollectionViewCell
class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    @IBOutlet weak var currentHightAndLowTempLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    func configureCurrentWeatherCollectionViewCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: model.lat, longitude: model.lon)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality { self.currentCityLabel.text = city }
            }
        })
        
        currentTempLabel.text = "\(model.current.temp)"
        currentDescriptionLabel.text = "\(model.current.weather[0].weatherDescription)"
        currentHightAndLowTempLabel.text = "H: \(Int(model.daily[indexPath.row].temp.max))° L:\(Int(model.daily[indexPath.row].temp.min))°"
    }
}

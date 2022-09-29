//
//  DayWeatherPerHourCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 11.07.2022.
//

import UIKit
import SwiftUI

//MARK: - DayWeatherPerHourCollectionViewCell
class DayWeatherPerHourCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    func configureWeatherPerHour(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        
        let myUnixTime = TimeInterval(model.hourly[indexPath.row].dt)
        let myTime = NSDate(timeIntervalSince1970: myUnixTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        hourLabel.text = formatter.string(from: myTime as Date)
        tempLabel.text = "\(Int((model.hourly[indexPath.row].temp)))°"
        weatherImage.image = UIImage(named: (model.hourly[indexPath.row].weather.first?.icon) ?? "")
    }
}

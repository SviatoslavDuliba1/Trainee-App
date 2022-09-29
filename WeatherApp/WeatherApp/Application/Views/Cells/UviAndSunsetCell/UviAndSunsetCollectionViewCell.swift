//
//  UviAndSunsetCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import UIKit

//MARK: - UviAndSunsetCollectionViewCell
class UviAndSunsetCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var UviAndSunsetLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    //MARK: - Methods
    func configure1UviAndSunsetCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        
        UviAndSunsetLabel.font = UIFont.systemFont(ofSize: 30)
        UviAndSunsetLabel.text = "\(Int(model.current.uvi))"
    }
    
    func configure2UviAndSunsetCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        UviAndSunsetLabel.font = UIFont.systemFont(ofSize: 17)
        let myUnixTimeSunset = TimeInterval(model.current.sunset ?? 0)
        let myUnixTimeSunrise = TimeInterval(model.current.sunrise ?? 0)
        let myTimeSunset = NSDate(timeIntervalSince1970: myUnixTimeSunset)
        let myTimeSunrise = NSDate(timeIntervalSince1970: myUnixTimeSunrise)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        UviAndSunsetLabel.text = "Sunset: \(formatter.string(from: myTimeSunset as Date)) \n\nSunrise: \(formatter.string(from: myTimeSunrise as Date))"
    }
}

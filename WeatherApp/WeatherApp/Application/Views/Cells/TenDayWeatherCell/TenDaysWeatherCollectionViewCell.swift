//
//  TenDaysWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 11.07.2022.
//

import UIKit

//MARK: - TenDaysWeatherCollectionViewCell
class TenDaysWeatherCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var DayLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    func configureWeatherPerDay(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        
        let myUnixTime = TimeInterval(model.daily[indexPath.row].dt)
        let myTime = NSDate(timeIntervalSince1970: myUnixTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        
        DayLabel.text = formatter.string(from: myTime as Date)
        tempMaxLabel.text = "\(Int((model.daily[indexPath.row].temp.max)))°"
        tempMinLabel.text = "\(Int((model.daily[indexPath.row].temp.min)))°"
        weatherImage.image = UIImage(named: (model.daily[indexPath.row].weather.first?.icon) ?? "")
    }
}

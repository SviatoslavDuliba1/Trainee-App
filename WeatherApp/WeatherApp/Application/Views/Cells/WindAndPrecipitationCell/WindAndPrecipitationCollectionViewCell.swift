//
//  WindAndPrecipitationCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import UIKit

//MARK: - WindAndPrecipitationCollectionViewCell
class WindAndPrecipitationCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var WindAndPrecipitationLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    //MARK: - Methods
    func configure1WindAndPrecipitationCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        WindAndPrecipitationLabel.font = UIFont.systemFont(ofSize: 17)
        WindAndPrecipitationLabel.text = "Speed:\(Int(model.current.windSpeed)) m/s \n Gust: \(Int((model.current.windGust) ?? 0)) m/s \n Direction: \(model.current.windDeg)°"
    }
    
    func configure2WindAndPrecipitationCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        WindAndPrecipitationLabel.font = UIFont.systemFont(ofSize: 30)
        WindAndPrecipitationLabel.text = "\(Int((model.daily[0].rain) ?? 0)) mm"
    }
}

//
//  FeelsLikeAndHumidityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import UIKit

//MARK: - FeelsLikeAndHumidityCollectionViewCell
class FeelsLikeAndHumidityCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var feelsLikeAndHumidity: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    //MARK: - Methods
    func configure1FeelsLikeAndHumidityCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        
        feelsLikeAndHumidity.text = "\(Int((model.current.feelsLike)))°"
    }
    
    func configure2FeelsLikeAndHumidityCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        
        feelsLikeAndHumidity.text = "\(model.current.humidity) %"
    }
}

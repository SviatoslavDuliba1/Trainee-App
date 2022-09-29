//
//  VisibilityAndPresureCollectionViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import UIKit

//MARK: - VisibilityAndPresureCollectionViewCell
class VisibilityAndPresureCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var visibilityAndPresureLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    //MARK: - Methods
    func configure1VisibilityAndPresureCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        visibilityAndPresureLabel.text = "\((model.current.visibility)/1000) km"
    }
    
    func configure2VisibilityAndPresureCell(model: MainWeatherParameters?, indexPath: IndexPath) {
        guard let model = model else {
            return
        }
        visibilityAndPresureLabel.text = "\(model.current.pressure) hPa"
    }
}

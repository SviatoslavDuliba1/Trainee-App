//
//  PresureCollectionReusableView.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 14.07.2022.
//

import UIKit

//MARK: - PresureCollectionReusableView
class PresureCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
    }
}

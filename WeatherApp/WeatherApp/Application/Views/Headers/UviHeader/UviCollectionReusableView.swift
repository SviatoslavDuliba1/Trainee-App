//
//  UviCollectionReusableView.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 14.07.2022.
//

import UIKit

//MARK: - UviCollectionReusableView
class UviCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
    }
}

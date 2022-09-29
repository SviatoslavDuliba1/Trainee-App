//
//  BackgroundSupplementaryView.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 23.08.2022.
//

import UIKit

//MARK: - BackgroundSupplementaryView
class BackgroundSupplementaryView: UICollectionReusableView {
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBlurEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func addBlurEffect() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 0.306, green: 0.485, blue: 0.746, alpha: 0.35)
    }
}

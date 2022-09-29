//
//  MainNavigationController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit

//MARK: - MainNavigationController
class MainNavigationController: UINavigationController {
    
    //MARK: - Properties
    private var viewController: UIViewController {
        let viewController = MainViewController.instantiateFromStoryboard(name: "WeatherViewController")
        let presenter = MainViewPresenter(mainView: viewController as MainViewProtocol)
        viewController.pagePresenter = presenter
        return viewController
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRootViewController()
    }
    
    //MARK: - Private Methods
    private func setRootViewController() {
        self.viewControllers = [viewController]
    }
}

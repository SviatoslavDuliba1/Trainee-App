//
//  ViewController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Alamofire
import UIKit
import CoreLocation

//MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
}

//MARK: - ViewController
class MainViewController: UIViewController {
    
    //MARK: - Properties
    var pagePresenter: MainViewPresenterProtocol!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PageViewController {
            controller.presenter = self.pagePresenter
            self.pagePresenter.pageView = controller as PageViewProtocol
        }
        
        if let controller = segue.destination as? CityListTableViewController {
            let presenter = CityListPresenter(tableView: controller)
            controller.cityPresenter = presenter
            controller.pageDelegate = self
            controller.delegate = self
        }
    }
}

//MARK: - Extensions MainViewController
extension MainViewController: CityListTableViewControllerDelegate {
}

extension MainViewController: MainViewProtocol {
}

extension MainViewController: PageViewDelegateProtocol{
    func updatePageView() {
    }
    
    func createNewPage(city: ParametersOfCity) {
        pagePresenter.createNewPage(city: city)
    }
    
    func reloadPageView() {
        pagePresenter.reloadPageView()
    }
}

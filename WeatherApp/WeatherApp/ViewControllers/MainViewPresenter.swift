//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 04.08.2022.
//

import Foundation

//MARK: - MainViewPresenterProtocol
protocol MainViewPresenterProtocol {
    var pageView: PageViewProtocol? { get set }
    func createNewPage(city: ParametersOfCity)
    func displaySavedCities()
    func reloadPageView()
}

//MARK: - MainViewPresenter
final class MainViewPresenter {
    
    //MARK: - Properties
    private weak var mainView: MainViewProtocol?
    weak var pageView: PageViewProtocol?
    
    //MARK: - Life Cycle
    init(mainView: MainViewProtocol) {
        self.mainView = mainView
    }
}

//MARK: - Extension MainViewPresenter
extension MainViewPresenter: MainViewPresenterProtocol {
    func createNewPage(city: ParametersOfCity) {
        pageView?.createNewPage(city: city)
    }
    
    func displaySavedCities() {
        pageView?.displaySavedCities()
    }
    
    func reloadPageView() {
        pageView?.reloadPageView()
    }
}

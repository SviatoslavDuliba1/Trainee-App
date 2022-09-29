//
//  CityListViewPresenter.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import Foundation
import RealmSwift

//MARK: - CityListPresenterProtocol
protocol CityListPresenterProtocol {
    func tableViewLoaded()
    func listOfCityAndCountry() -> [ParametersOfCity]
    func displayListOfCities(by text: String)
}

//MARK: - CityListPresenter
final class CityListPresenter {
    
    //MARK: - Properties
    var tableView: CityListTableViewProtocol?
    private var cities: [ParametersOfCity] = []
    private var selectedCityList: [ParametersOfCity] = []
    private let network = WeatherProject.shared.network
    
    //MARK: - Life Cycle
    init(tableView: CityListTableViewProtocol) {
        self.tableView = tableView
        convertJson()
    }
    
    //MARK: - Private Methods
    private func convertLocalCityListJSON(name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                return data
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func convert(json: Data) -> [ParametersOfCity]? {
        do {
            let convertData = try JSONDecoder().decode([ParametersOfCity].self, from: json)
            return convertData
        } catch {
            print(error)
        }
        return nil
    }
    
    private func convertJson() {
        let json = convertLocalCityListJSON(name: "city_list")
        guard let data = json else {return}
        if let dataObjects = convert(json: data) {
            cities = dataObjects
        }
    }
}

//MARK: - Extensions CityListPresenter
extension CityListPresenter: CityListPresenterProtocol {
    
    //MARK: - Methods
    func displayListOfCities(by text: String) {
        if text.isEmpty {
            selectedCityList.removeAll()
        } else {
            selectedCityList = cities.filter({ city in
                let nameOfCity = city.name
                return (nameOfCity.starts(with: text))
            })
        }
        tableView?.tableViewReloadData()
    }
    
    func listOfCityAndCountry() -> [ParametersOfCity] {
        selectedCityList
    }
    
    func tableViewLoaded() {
        tableView?.setupUI()
    }
}

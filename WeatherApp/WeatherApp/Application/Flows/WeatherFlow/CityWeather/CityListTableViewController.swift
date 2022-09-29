//
//  CityListTableViewController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 19.07.2022.
//

import CoreLocation
import RealmSwift
import SwiftUI
import UIKit

//MARK: - CityListTableViewProtocol
protocol CityListTableViewProtocol: AnyObject {
    func setupUI()
    func tableViewReloadData()
}

//MARK: - CityListTableViewControllerDelegate
protocol CityListTableViewControllerDelegate: AnyObject {
}

//MARK: - CityListTableViewController
class CityListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var delegate: CityListTableViewControllerDelegate?
    var cityPresenter: CityListPresenterProtocol!
    var pageDelegate: PageViewDelegateProtocol?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPresenter.tableViewLoaded()
        configureTableView()
    }
    
    //MARK: - Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchBar.text == "" {
            return numberOfSavedCities()
        }else {
            return cityPresenter.listOfCityAndCountry().count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searchBar.text == "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCitiesCustomCell") as! SavedCitiesTableViewCell
            cell.configureSavedCitiesTableViewCell(indexPath: indexPath)
            return cell
        }else {
            return createCell(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteSavedCities(indexPath: indexPath)
            tableView.endUpdates()
            pageDelegate?.reloadPageView()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pageDelegate?.createNewPage(city: cityPresenter.listOfCityAndCountry()[indexPath.row])
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions CityListTableViewController
extension CityListTableViewController: CityListTableViewProtocol {
    
    //MARK: - Methods
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func setupUI() {
        searchBar.delegate = self
    }
}

extension CityListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cityPresenter.displayListOfCities(by: searchText)
    }
}

extension CityListTableViewController {
    func createCell(indexPath: IndexPath) -> UITableViewCell {
        let cellCityAndCountry = cityPresenter.listOfCityAndCountry()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityAndCountry")! as UITableViewCell
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = "\(cellCityAndCountry.name), \(cellCityAndCountry.country)"
        return cell
    }
    
    func numberOfSavedCities() -> Int {
        let realm = try! Realm()
        let results = realm.objects(CitiesDatabase.self)
        return results.count
    }
    
    func deleteSavedCities(indexPath: IndexPath) {
        let realm = try! Realm()
        let savedCites = realm.objects(CitiesDatabase.self)
        realm.beginWrite()
        realm.delete(savedCites[indexPath.row])
        try! realm.commitWrite()
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "SavedCitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "SavedCitiesCustomCell")
    }
}

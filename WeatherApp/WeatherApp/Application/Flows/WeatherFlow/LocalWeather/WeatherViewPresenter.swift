//
//  WeatherViewPresenter.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 11.07.2022.
//

import CoreLocation
import Foundation
import RealmSwift

//MARK: - WeatherPresenterProtocol
protocol WeatherPresenterProtocol {
    var model: MainWeatherParameters? {get set}
    var collectionView: CollectionViewProtocol? {get set}
    func getWeatherByLocation(longitude: Double, latitude: Double)
    func viewLoaded()
    func saveNewCity()
    func showAlert()
}

//MARK: - WeatherViewPresenter
final class WeatherViewPresenter {
    
    //MARK: - Properties
    weak var viewControler: WeatherViewProtocol!
    var cityPresenter: CityListPresenterProtocol!
    private weak var view: WeatherViewProtocol?
    var collectionView: CollectionViewProtocol?
    var pageDelegate: PageViewDelegateProtocol?
    var model: MainWeatherParameters?
    var modelCity: ParametersOfCity?
    var longitude: Double?
    var latitude: Double?
    var cityName: String?
    var countryName: String?
    lazy var locationManager = LocationManager(viewControler: WeatherViewController())
    
    //MARK: - Life Cycle
    init (view: WeatherViewProtocol,
          cityName: String?,
          countryName: String?,
          longitude: Double?,
          latitude: Double?) {
        self.view = view
        self.cityName = cityName
        self.countryName = countryName
        self.longitude = longitude
        self.latitude = latitude
        if longitude == nil || latitude == nil {
            locationManager.delegate = self
            locationManager.locationRequest()
        } else {
            let currentLocation = CLLocationCoordinate2D(latitude: self.latitude ?? 0,
                                                         longitude: self.longitude ?? 0)
            updateCoordinate(location: currentLocation )
        }
    }
    
    //MARK: - Methods
    func getWeatherBySelectedCity(longitude: Double, latitude: Double) {
        WeatherProject.shared.network.currentLocationWeather(longitude: longitude,
                                                             latitude: latitude)
            .done{ [weak self] response in
                Log.info(response)
                guard let self = self else {return}
                self.model = response
                self.saveNewCity()
                self.collectionView?.reloadData()
                self.view?.confirugeMainHeader(model: self.model)
            }.catch {error in
                Log.error(error.localizedDescription)
            }
    }
}

//MARK: - Extensions WeatherViewPresenter
extension WeatherViewPresenter: LocationManagerDelegate {
    func updateCoordinate(location: CLLocationCoordinate2D) {
        if latitude == nil {
            getWeatherByLocation(longitude: location.longitude,
                                 latitude: location.latitude)
        } else {
            getWeatherBySelectedCity(longitude: location.longitude, latitude: location.latitude)
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "TITLE",
                                                message: "Please go to Setting and turn on the permissions",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
//        viewControler.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherViewPresenter: WeatherPresenterProtocol {
    
    func getWeatherByLocation(longitude: Double, latitude: Double) {
        WeatherProject.shared.network.currentLocationWeather(longitude: longitude,
                                                             latitude: latitude)
            .done { [weak self] response in
                Log.info(response)
                guard let self = self else { return }
                self.model = response
                self.collectionView?.reloadData()
                self.view?.confirugeMainHeader(model: self.model)
            }.catch {error in
                Log.error(error.localizedDescription)
            }
    }
    
    func viewLoaded() {
        collectionView?.reloadData()
    }
    
    func updateData(model: MainWeatherParameters) {
        self.model = model
    }
    
    func saveNewCity() {
        let realm = try! Realm()
        let newCity = CitiesDatabase()
        let results = realm.objects(CitiesDatabase.self).filter("name = '\(cityName!)' && country = '\(countryName!)'")
        
        guard let longitude = longitude else {return}
        newCity.longitude = longitude
        
        guard let latitude = latitude else {return}
        newCity.latitude = latitude
        
        if results.count == 1 {
            pageDelegate?.updatePageView()
            updateCitiesDatabase()
        }else {
            newCity.name = cityName!
            newCity.country = countryName!
            newCity.temperature = model?.current.temp ?? 0
            newCity.timeZoneOfSet = model?.timezoneOffset ?? 0
            newCity.weatherDescription = model?.current.weather[0].weatherDescription ?? "Not found"
            newCity.lowTemperature = model?.daily[0].temp.min ?? 0
            newCity.HightTemperature = model?.daily[0].temp.max ?? 0
            realm.beginWrite()
            realm.add(newCity)
            try! realm.commitWrite()
        }
    }
    
    func updateCitiesDatabase() {
        let realm = try! Realm()
        let savedCities = realm.objects(CitiesDatabase.self)
        for city in savedCities {
            if cityName == city.name {
                realm.beginWrite()
                city.temperature = model?.current.temp ?? 0
                city.timeZoneOfSet = model?.timezoneOffset ?? 0
                city.weatherDescription = model?.current.weather[0].weatherDescription ?? "Not found"
                city.lowTemperature = model?.daily[0].temp.min ?? 0
                city.HightTemperature = model?.daily[0].temp.max ?? 0
                try! realm.commitWrite()
            }
        }
    }
}


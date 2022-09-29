//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 11.07.2022.
//

import CoreLocation
import SwiftUI
import UIKit

//MARK: - WeatherViewProtocol
protocol WeatherViewProtocol: AnyObject {
    func reloadData(model: MainWeatherParameters)
    func confirugeMainHeader(model: MainWeatherParameters?)
}

//MARK: - WeatherViewController
final class WeatherViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var cityCurrentLabel: UILabel!
    @IBOutlet weak var tempCurrentLabel: UILabel!
    @IBOutlet weak var descriptionCurrenLabel: UILabel!
    @IBOutlet weak var hightAndLowCurrentLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - Properties
    var cityPresenter: CityListPresenterProtocol!
    var presenter: WeatherPresenterProtocol!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CollectionViewController {
            controller.presenter = self.presenter
            self.presenter.collectionView = controller as CollectionViewProtocol
        }
    }
}

//MARK: - Extesions WeatherViewController
extension WeatherViewController: WeatherViewProtocol {
    
    func reloadData(model: MainWeatherParameters) {
        view.reloadInputViews()
    }
    
    func confirugeMainHeader(model: MainWeatherParameters?) {
        guard let model = model else {
            return
        }
        reloadData(model: model)
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: model.lat, longitude: model.lon)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality { self.cityCurrentLabel.text = city }
            }
        })
        
        tempCurrentLabel.text = "\(Int(model.current.temp))°"
        descriptionCurrenLabel.text = "\(model.current.weather[0].weatherDescription)"
        hightAndLowCurrentLabel.text = "H: \(Int(model.daily[0].temp.max))° L:\(Int(model.daily[0].temp.min))°"
        
        let mainWeatherDescription: String = model.current.weather[0].main ?? ""
        switch mainWeatherDescription {
        case "Thunderstorm":
            backgroundImageView.image = #imageLiteral(resourceName: "thunderstorm-1")
        case "Drizzle":
            backgroundImageView.image = #imageLiteral(resourceName: "Drizzle")
        case "Rain":
            backgroundImageView.image = #imageLiteral(resourceName: "rain-1")
        case "Snow":
            backgroundImageView.image = #imageLiteral(resourceName: "snow-1")
        case "Clear":
            backgroundImageView.image = #imageLiteral(resourceName: "background")
        case "Clouds":
            backgroundImageView.image = #imageLiteral(resourceName: "cloud-1")
        default:
            backgroundImageView.image = #imageLiteral(resourceName: "mist-1")
        }
    }
}

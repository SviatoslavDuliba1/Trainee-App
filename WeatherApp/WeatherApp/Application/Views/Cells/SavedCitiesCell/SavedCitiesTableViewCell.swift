//
//  SavedCitiesTableViewCell.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 08.09.2022.
//
import RealmSwift
import UIKit

//MARK: - SavedCitiesTableViewCell
class SavedCitiesTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var cityWeatherImage: UIImageView!
    @IBOutlet weak var savedCityNameLabel: UILabel!
    @IBOutlet weak var savedCityTimeLabel: UILabel!
    @IBOutlet weak var savedCityTemperatureLabel: UILabel!
    @IBOutlet weak var savedCityWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var savedCityLowTemperatureLabel: UILabel!
    @IBOutlet weak var savedCityHightTemperatureLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.layer.cornerRadius = 8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureSavedCitiesTableViewCell(indexPath: IndexPath) {
        let realm = try! Realm()
        let results = realm.objects(CitiesDatabase.self)
        savedCityNameLabel.text = "\(results[indexPath.row].name ?? "Not found")"
        //        savedCityTimeLabel.text =
        savedCityTemperatureLabel.text = "\(Int(results[indexPath.row].temperature))°"
        savedCityWeatherDescriptionLabel.text = "\(results[indexPath.row].weatherDescription ?? "")"
        savedCityHightTemperatureLabel.text = "H: \(Int(results[indexPath.row].HightTemperature))°"
        savedCityLowTemperatureLabel.text = "L: \(Int(results[indexPath.row].lowTemperature))°"
        
        let description: String = "\(results[indexPath.row].weatherDescription ?? "")"
        switch description {
        case "few clouds":
            cityWeatherImage.image = #imageLiteral(resourceName: "fewClouds.png")
            savedCityHightTemperatureLabel.textColor = .darkGray
            savedCityLowTemperatureLabel.textColor = .darkGray
            savedCityWeatherDescriptionLabel.textColor = .darkGray
            savedCityNameLabel.textColor = .darkGray
            savedCityTimeLabel.textColor = .darkGray
            savedCityTemperatureLabel.textColor = .darkGray
        case "scattered clouds":
            cityWeatherImage.image = #imageLiteral(resourceName: "scatteredClouds.png")
        case "broken clouds", "overcast clouds":
            cityWeatherImage.image = #imageLiteral(resourceName: "brokenClouds.png")
        case "clear sky":
            cityWeatherImage.image = #imageLiteral(resourceName: "clearSky.png")
        case "tornado", "squalls", "volcanic ash", "dust", "sand", "fog", "sand/ dust whirls", "Haze", "Smoke", "mist":
            cityWeatherImage.image = #imageLiteral(resourceName: "mist.png")
        case "Heavy shower snow", "Shower snow", "Light shower snow", "Rain and snow", "Light rain and snow", "Shower sleet", "Light shower sleet", "Sleet", "Heavy snow", "Snow", "light snow":
            cityWeatherImage.image = #imageLiteral(resourceName: "snow.png")
        case "ragged shower rain", "heavy intensity shower rain", "shower rain", "light intensity shower rain", "freezing rain", "extreme rain", "very heavy rain", "heavy intensity rain", "moderate rain", "light rain", "shower drizzle", "heavy shower rain and drizzle", "shower rain and drizzle", "heavy intensity drizzle rain", "drizzle rain", "light intensity drizzle rain", "heavy intensity drizzle", "drizzle", "light intensity drizzle":
            cityWeatherImage.image = #imageLiteral(resourceName: "rain.png")
        case "thunderstorm with heavy drizzle", "thunderstorm with drizzle", "thunderstorm with light drizzle", "ragged thunderstorm", "heavy thunderstorm", "thunderstorm", "light thunderstorm", "thunderstorm with heavy rain", "thunderstorm with rain", "thunderstorm with light rain":
            cityWeatherImage.image = #imageLiteral(resourceName: "thunderstorm.png")
        default:
            cityWeatherImage.image = #imageLiteral(resourceName: "mist.png")
        }
    }
}

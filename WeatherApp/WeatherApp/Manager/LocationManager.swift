//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Foundation
import CoreLocation
import UIKit

//MARK: - LocationManagerDelegate
protocol LocationManagerDelegate: AnyObject {
    func updateCoordinate(location: CLLocationCoordinate2D)
    func showAlert()
}

//MARK: - LocationManager
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    //MARK: - Privat Properties
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
  //  private var viewControler: UIViewController
    private var presenter: WeatherPresenterProtocol!
    
    //MARK: - Life cycle
    init(viewControler: UIViewController) {
  //      self.viewControler = viewControler
        super.init()
        locationManager.delegate = self
    }
    
    //MARK: - Methods
    func locationRequest() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations currentLocation: [CLLocation]) {
        guard let location = currentLocation.first else { return }
        locationManager.stopMonitoringSignificantLocationChanges()
        delegate?.updateCoordinate(location: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            delegate?.showAlert()
        }
        print("location manager authorization status changed")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}

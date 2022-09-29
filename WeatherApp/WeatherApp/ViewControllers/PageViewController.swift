//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 26.07.2022.
//

import UIKit
import RealmSwift

//MARK: - PageViewProtocol
protocol PageViewProtocol: AnyObject {
    func createNewPage(city: ParametersOfCity)
    func displaySavedCities()
    func reloadPageView()
}

//MARK: - PageViewDelegateProtocol
protocol PageViewDelegateProtocol: AnyObject {
    func createNewPage(city: ParametersOfCity)
    func reloadPageView()
    func updatePageView()
}

//MARK: - PageViewController
class PageViewController: UIPageViewController {
    
    //MARK: - Properties
    var pages = [UIViewController]()
    var pageControl = UIPageControl()
    let initialPage = 0
    var presenter: MainViewPresenterProtocol?
    var delegateCity: CityListTableViewProtocol?
    var pagePresenter: PageViewProtocol?
    var cityName: String?
    var countryName: String?
    var cityLon: Double?
    var cityLat: Double?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        displaySavedCities()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "Path to database not found", "!@#")
    }
}

//MARK: - Extensions PageViewController
extension PageViewController {
    func setup() {
        dataSource = self
        delegate = self
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 = WeatherViewController.instantiateFromStoryboard()
        let presenter = WeatherViewPresenter(view: page1, cityName: nil, countryName: nil, longitude: nil, latitude: nil)
        page1.presenter = presenter
        pages.append(page1)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1)
        ])
    }
}

extension PageViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else {return}
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else {return}
        pageControl.currentPage = currentIndex
    }
}

extension PageViewController: PageViewProtocol {
    func createNewPage(city: ParametersOfCity) {
        let page = WeatherViewController.instantiateFromStoryboard()
        let presenter = WeatherViewPresenter(view: page,
                                             cityName: city.name,
                                             countryName: city.country,
                                             longitude: city.coord.lon,
                                             latitude: city.coord.lat)
        page.presenter = presenter
        presenter.pageDelegate = self
        presenter.collectionView?.reloadData()
        pages.append(page)
        self.dataSource = nil
        self.dataSource = self
        style()
    }
    
    func displaySavedCities() {
        let realm = try! Realm()
        let savedCities = realm.objects(CitiesDatabase.self)
        for city in savedCities {
            let savedCityName = city.name
            let savedCountryName = city.country
            let savedCityLongitude = city.longitude
            let savedCityLatitude = city.latitude
            
            self.cityName = savedCityName!
            self.countryName = savedCountryName
            self.cityLat = savedCityLatitude
            self.cityLon = savedCityLongitude
            
            let page = WeatherViewController.instantiateFromStoryboard()
            let presenter = WeatherViewPresenter(view: page,
                                                 cityName: cityName,
                                                 countryName: countryName,
                                                 longitude: cityLon,
                                                 latitude: cityLat)
            page.presenter = presenter
            presenter.collectionView?.reloadData()
            pages.append(page)
            self.dataSource = nil
            self.dataSource = self
            style()
        }
    }
    
    func reloadPageView() {
        pages.removeAll()
        setup()
        displaySavedCities()
    }
}

extension PageViewController: PageViewDelegateProtocol {
    func updatePageView() {
        reloadPageView()
    }
}


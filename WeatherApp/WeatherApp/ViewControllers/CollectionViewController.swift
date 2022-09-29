//
//  CollectionViewController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 11.07.2022.
//
import Alamofire
import UIKit

//MARK: - CollectionViewProtocol
protocol CollectionViewProtocol: AnyObject {
    func reloadData()
}

//MARK: - CollectionViewController
class CollectionViewController: UICollectionViewController {
    
    //MARK: - Properties
    var presenter: WeatherPresenterProtocol?
    
    //MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    // MARK: -  UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return WeatherSection.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let section = WeatherSection.allCases[section]
        switch section {
        case .DayWeatherPerHour:
            return presenter?.model?.hourly.count ?? 0
        case .TenDaysWeather:
            return presenter?.model?.daily.count ?? 0
        case .UviAndSunset:
            return 2
        case .WindAndPrecipitation:
            return 2
        case .FeelsLikeAndHumidity:
            return 2
        case .VisibilityAndPresure:
            return 2
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let select = WeatherSection.allCases[indexPath.section]
        switch select {
        case .DayWeatherPerHour:
            let cellForDayWeather = collectionView.dequeueCell(DayWeatherPerHourCollectionViewCell.self, indexPath: indexPath)
            cellForDayWeather.configureWeatherPerHour(model: presenter?.model, indexPath: indexPath)
            return cellForDayWeather
        case .TenDaysWeather:
            let cellForTenDaysWeather = collectionView.dequeueCell(TenDaysWeatherCollectionViewCell.self, indexPath: indexPath)
            cellForTenDaysWeather.configureWeatherPerDay(model: presenter?.model, indexPath: indexPath)
            return cellForTenDaysWeather
        case .UviAndSunset:
            let cellUviAndSunset = collectionView.dequeueCell(UviAndSunsetCollectionViewCell.self, indexPath: indexPath)
            let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath) ?? cellUviAndSunset
            
            switch indexPath.row {
            case 0:
                cellUviAndSunset.configure1UviAndSunsetCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            case 1:
                cellUviAndSunset.configure2UviAndSunsetCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            default:
                cell.backgroundColor = .white
            }
            
            return cellUviAndSunset
        case .WindAndPrecipitation:
            let cellWindAndPrecipitation = collectionView.dequeueCell(WindAndPrecipitationCollectionViewCell.self, indexPath: indexPath)
            let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath) ?? cellWindAndPrecipitation
            
            switch indexPath.row {
            case 0:
                cellWindAndPrecipitation.configure1WindAndPrecipitationCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            case 1:
                cellWindAndPrecipitation.configure2WindAndPrecipitationCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            default:
                cell.backgroundColor = .white
            }
            
            return cellWindAndPrecipitation
        case .FeelsLikeAndHumidity:
            let cellFeelsLikeAndHumidity = collectionView.dequeueCell(FeelsLikeAndHumidityCollectionViewCell.self, indexPath: indexPath)
            let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath) ?? cellFeelsLikeAndHumidity
            
            switch indexPath.row {
            case 0:
                cellFeelsLikeAndHumidity.configure1FeelsLikeAndHumidityCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            case 1:
                cellFeelsLikeAndHumidity.configure2FeelsLikeAndHumidityCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            default:
                cell.backgroundColor = .white
            }
            
            return cellFeelsLikeAndHumidity
        case .VisibilityAndPresure:
            let cellVisibilityAndPresure = collectionView.dequeueCell(VisibilityAndPresureCollectionViewCell.self, indexPath: indexPath)
            let cell:UICollectionViewCell = collectionView.cellForItem(at: indexPath) ?? cellVisibilityAndPresure
            
            switch indexPath.row {
            case 0:
                cellVisibilityAndPresure.configure1VisibilityAndPresureCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            case 1:
                cellVisibilityAndPresure.configure2VisibilityAndPresureCell(model: presenter?.model, indexPath: indexPath as IndexPath)
            default:
                cell.backgroundColor = .white
            }
            
            return cellVisibilityAndPresure
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let kind = WeatherSection.allCases[indexPath.section]
        
        switch kind {
        case .DayWeatherPerHour:
            let headerDayView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "\(HeaderDayWeatherSectionCollectionReusableView.self)",
                for: indexPath) as! HeaderDayWeatherSectionCollectionReusableView
            return headerDayView
        case .TenDaysWeather:
            let headerTenDaysView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "\(HeaderTenDaysWeatherCollectionReusableView.self)",
                for: indexPath) as! HeaderTenDaysWeatherCollectionReusableView
            return headerTenDaysView
        case .UviAndSunset:
            let headerUviAndSunset = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "\(UviCollectionReusableView.self)",
                for: indexPath) as! UviCollectionReusableView
            return headerUviAndSunset
        case .WindAndPrecipitation:
            let headerWindAndPrecipitation = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "\(WindCollectionReusableView.self)",
                for: indexPath) as! WindCollectionReusableView
            return headerWindAndPrecipitation
        case .FeelsLikeAndHumidity:
            let headerFeelsLikeAndHumidity = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "\(FeelsLikeCollectionReusableView.self)",
                for: indexPath) as! FeelsLikeCollectionReusableView
            return headerFeelsLikeAndHumidity
        case .VisibilityAndPresure:
            let headerVisibilityAndPresure = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "\(VisibilityCollectionReusableView.self)",
                for: indexPath) as! VisibilityCollectionReusableView
            return headerVisibilityAndPresure
        }
    }
    
    //MARK: - Methods
    func createLayout() ->  UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
            switch WeatherSection.allCases[sectionIndex] {
            case .DayWeatherPerHour:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                      heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let sectionBackgruond = NSCollectionLayoutDecorationItem.background(elementKind: "background-element-kind")
                sectionBackgruond.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
                section.decorationItems = [sectionBackgruond]
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .fractionalHeight(0.025))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                sectionHeader.pinToVisibleBounds = true
                return section
                
            case .TenDaysWeather:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(0.5))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(0.8))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let sectionBackgruond = NSCollectionLayoutDecorationItem.background(elementKind: "background-element-kind")
                sectionBackgruond.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
                section.decorationItems = [sectionBackgruond]
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .fractionalHeight(0.025))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                sectionHeader.pinToVisibleBounds = true
                return section
            case .UviAndSunset:
                return self.configureDescriptionCell()
            case .WindAndPrecipitation:
                return self.configureDescriptionCell()
            case .FeelsLikeAndHumidity:
                return self.configureDescriptionCell()
            case .VisibilityAndPresure:
                return self.configureDescriptionCell()
            }
        }
        layout.register(BackgroundSupplementaryView.self, forDecorationViewOfKind: "background-element-kind")
        return layout
    }
    
    func configureDescriptionCell() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10,
                                      leading: 10,
                                      bottom: 10,
                                      trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(0.025))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        sectionHeader.pinToVisibleBounds = true
        return section
    }
    
    func configureCollectionView() {
        
        collectionView.registerCell(DayWeatherPerHourCollectionViewCell.self)
        collectionView.registerCell(TenDaysWeatherCollectionViewCell.self)
        collectionView.registerCell(WindAndPrecipitationCollectionViewCell.self)
        collectionView.registerCell(FeelsLikeAndHumidityCollectionViewCell.self)
        collectionView.registerCell(VisibilityAndPresureCollectionViewCell.self)
        collectionView.registerCell(UviAndSunsetCollectionViewCell.self)
        
        collectionView.register(UINib(nibName: "HeaderTenDaysWeatherCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "HeaderTenDaysWeatherCollectionReusableView")
        collectionView.register(UINib(nibName: "HeaderDayWeatherSectionCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "HeaderDayWeatherSectionCollectionReusableView")
        collectionView.register(UINib(nibName: "UviCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "UviCollectionReusableView")
        collectionView.register(UINib(nibName: "WindCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "WindCollectionReusableView")
        collectionView.register(UINib(nibName: "FeelsLikeCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "FeelsLikeCollectionReusableView")
        collectionView.register(UINib(nibName: "VisibilityCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "VisibilityCollectionReusableView")
        collectionView.collectionViewLayout = createLayout()
    }
}

//MARK: - Extensions CollectionViewController
extension CollectionViewController: CollectionViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}

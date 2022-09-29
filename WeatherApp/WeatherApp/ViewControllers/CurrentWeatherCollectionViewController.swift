//
//  CurrentWeatherCollectionViewController.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 15.07.2022.
//
import Alamofire
import UIKit

//MARK: - CurrentWeatherCollectionViewController
class CurrentWeatherCollectionViewController: UICollectionViewController {
    
    //MARK: - Properties
    var presenter: WeatherPresenterProtocol?
    private let reuseIdentifier = "Cell"
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrentWeatherCollectionView()
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CurrentWeatherCollectionViewCell.self, indexPath: indexPath)
        cell.configureCurrentWeatherCollectionViewCell(model: presenter?.model, indexPath: indexPath)
        
        return cell
    }
    
    //MARK: - Methods
    func createLayout1() ->  UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 35, leading: 0, bottom: 0, trailing: 0)
            return section
        }
        return layout
    }
    
    func configureCurrentWeatherCollectionView() {
        collectionView.registerCell(CurrentWeatherCollectionViewCell.self)
        collectionView.collectionViewLayout = self.createLayout1()
    }
}

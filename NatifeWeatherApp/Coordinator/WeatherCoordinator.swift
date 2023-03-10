//
//  WeatherCoordinator.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

protocol CoordinatorProtocol {
    var navController: UINavigationController { get set }
    func start()
    func createMapView(viewController: UIViewController)
}

class WeatherCoordinator: CoordinatorProtocol {
    var navController: UINavigationController
    init(navController: UINavigationController) {self.navController = navController }

    func start() {
        let view = WeatherMainViewController()
        let networkManager = NetworkManager()
        let presenter = WeatherPresenter(view: view, networkManager: networkManager)

        view.presenter = presenter
        view.coordinator = self
        navController.pushViewController(view, animated: true)
    }
    
    func createMapView(viewController: UIViewController) {
        let view = WeatherMapViewController()
        view.coordinator = self
        if let viewController = viewController as? TopNameViewController {
            view.delegate = viewController
        }
        
        
        navController.navigationBar.topItem?.backButtonTitle = "" /// delete "back" title
        navController.pushViewController(view, animated: true)
    }
}

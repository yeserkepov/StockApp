//
//  ModuleBuilder.swift
//  HalykStocks
//
//  Created by Даурен on 29.05.2022.
//

import UIKit

final class ModuleBuilder {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    static let shared: ModuleBuilder = .init()
    
    private func networkService() -> NetworkService {
        network
    }
    
    private func stocksService() -> StocksServicesProtocol {
        StocksService(client: network)
    }
    
    private func detailsService() -> DetailsServicesProtocol {
        DetailsService(client: network)
    }
    
    private func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService())
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
    func detailsModule(with model: StockModelProtocol) -> UIViewController {
        let presenter = DetailsPresenter(service: detailsService(), model: model)
        let view = DetailsViewController(presenter: presenter)
        presenter.view = view
        view.hidesBottomBarWhenPushed = true
        
        return view
    }
    
    func tabBarController() -> UIViewController {
        let tabBar = UITabBarController()
        let stocksVC = stocksModule()
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "stocks"), tag: 0)
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite"), tag: 2)
        tabBar.viewControllers = [stocksVC, searchVC, favoriteVC].map { UINavigationController(rootViewController: $0) }
        
        return tabBar
    }
}

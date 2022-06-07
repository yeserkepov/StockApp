//
//  ModuleBuilder.swift
//  HalykStocks
//
//  Created by Даурен on 29.05.2022.
//

import UIKit

final class Assembly {
    
    static let assembler: Assembly = .init()
    let favoritesService: FavoriteServiceProtocol =  FavoriteService()
    private init () {}
    
    private lazy var network: NetworkService = Network()
    private lazy var stocksService: StocksServiceProtocol = StocksService(client: network)
    private lazy var stocksPresenter: StocksPresenterProtocol = StocksPresenter(service: stocksService)
    private lazy var detailsService: DetailsServicesProtocol =  DetailsService(client: network)
    
    private func stocksModule() -> UIViewController {
        let view = StocksViewController(presenter: stocksPresenter)
        stocksPresenter.view = view
        return view
    }
    
    private func favoriteModule() -> UIViewController {
        let presenter = FavoritePresenter(service: stocksService)
        let view = FavoriteViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func detailsModule(with model: StockModelProtocol) -> UIViewController {
        let presenter = DetailsPresenter(service: detailsService, model: model)
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
        let favoriteVC = favoriteModule()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite"), tag: 2)
        tabBar.viewControllers = [stocksVC,  favoriteVC, searchVC].map { UINavigationController(rootViewController: $0) }
        
        return tabBar
    }
}

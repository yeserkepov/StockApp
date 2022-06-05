//
//  MainViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = setupNavigationBar()
        
    }
    
    private func setupNavigationBar() -> [UIViewController] {
        var vc: [UIViewController] = []
        let stocksVC = createVC(rootVC: StocksViewController(), title: "Stocks", image: UIImage(named: "stocks")!)
        let searchVC = createVC(rootVC: SearchViewController(), title: "Search", image: UIImage(named: "search")!)
        let favoriteVC = createVC(rootVC: FavoriteViewController(), title: "Favorite", image: UIImage(named: "favorite")!)
        [stocksVC, searchVC, favoriteVC].forEach { controller in
            vc.append(controller)
        }
        return vc
    }
    
    private func createVC(rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootVC)
        rootVC.navigationItem.title = title
        rootVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}

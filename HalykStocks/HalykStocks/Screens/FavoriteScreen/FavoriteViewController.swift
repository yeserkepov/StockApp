//
//  FavoriteViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .cyan
        title = "Favorite"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

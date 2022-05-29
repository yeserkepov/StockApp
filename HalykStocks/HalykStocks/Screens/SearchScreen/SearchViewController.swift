//
//  SearchViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        view.backgroundColor = .orange
        title = "Search"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

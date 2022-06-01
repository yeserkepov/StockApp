//
//  FavoriteViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit
import SnapKit

final class FavoriteViewController: UIViewController {
    private let presenter: FavoritePresenterProtocol
    
    init(presenter: FavoritePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.loadView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Favorite"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-16)
            make.left.equalTo(view.snp.left).offset(16)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.favCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.setBackgroundColor(for: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(with: presenter.model(for: indexPath))

        return cell
        
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
}

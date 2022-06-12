//
//  SearchViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    private let presenter: SearchPresenterProtocol
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.delegate = presenter
        return view
    }()
    
    private lazy var searchTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Stocks"
        lbl.textAlignment = .left
        lbl.font = UIFont.customFont(name: .moserratBold, size: 18)
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubview()
        
        presenter.loadView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupSubview() {
        [searchView, searchTitle, tableView].forEach { view.addSubview($0) }
        
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(48)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        searchTitle.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func showError(_ message: Error) {
        print(message.localizedDescription)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.searchedStocksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Assembly.assembler.detailsModule(with: presenter.model(for: indexPath))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: StocksViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        // show or hide loader
    }
    
    func updateView(withError message: String) {
        // show error message
    }
    
    func updateCell(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

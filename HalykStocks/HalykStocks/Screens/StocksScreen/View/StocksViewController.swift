//
//  ViewController.swift
//  HalykStocks
//
//  Created by Даурен on 24.05.2022.
//

import UIKit
import SnapKit

final class StocksViewController: UIViewController {
    
    private var stocks: [Stock] = []
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        setupSubviews()
        
        getStocks()
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
    
    private func getStocks() {
        let client = Network()
        let service: StocksServicesProtocol = StocksService(client: client)
        
        service.getStocks { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.stocks = stocks
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
    
    private func showError(_ message: Error) {
        print(message.localizedDescription)
    }
}

extension StocksViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension StocksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = stocks[indexPath.row]
        let vc = DetailsViewController()
        vc.symbol = data.symbol
        vc.name = data.name
        vc.price = data.price
        vc.delta = data.change
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.setBackgroundColor(for: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(with: stocks[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
}

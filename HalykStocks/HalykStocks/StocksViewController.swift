//
//  ViewController.swift
//  HalykStocks
//
//  Created by Даурен on 24.05.2022.
//

import UIKit
import SnapKit

final class StocksViewController: UIViewController {
    
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

extension StocksViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension StocksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.setBackgroundColor(for: indexPath.row)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
}

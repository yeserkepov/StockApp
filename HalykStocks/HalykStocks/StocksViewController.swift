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
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        tableView.dataSource = self
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension StocksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
}

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}

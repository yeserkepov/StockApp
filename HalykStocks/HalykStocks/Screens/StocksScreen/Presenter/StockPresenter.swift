//
//  StockPresenter.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import Foundation

protocol StocksViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var stocksCount: Int { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
    private let service: StocksServicesProtocol
    private var stocks: [StockModelProtocol] = []
    
    var stocksCount: Int {
        stocks.count
    }
    
    init(service: StocksServicesProtocol) {
        self.service = service
    }
    
    weak var view: StocksViewProtocol?
    
    func loadView() {
        view?.updateView(withLoader: true)

        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stocks = stocks.map { StockModel(stock: $0) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        stocks[indexPath.row]
    }
}

//
//  FavoritePresenter.swift
//  HalykStocks
//
//  Created by Даурен on 01.06.2022.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol FavoritePresenterProtocol {
    var view: FavoriteViewProtocol? { get set }
    var favCount: Int { get }
    func loadView()
    func model(for index: IndexPath) -> StockModelProtocol
}

final class FavoritePresenter: FavoritePresenterProtocol {
    weak var view: FavoriteViewProtocol?
    private var favStocks: [StockModelProtocol] = []
    private var service: FavoriteServiceProtocol
    
    init(service: FavoriteServiceProtocol) {
        self.service = service
    }
    
    var favCount: Int {
        favStocks.count
    }
    
    func loadView() {
        favStocks = service.model().map { StockModel(stock: $0) }
        view?.updateView()
    }
    
    func model(for index: IndexPath) -> StockModelProtocol {
        favStocks[index.row]
    }
}

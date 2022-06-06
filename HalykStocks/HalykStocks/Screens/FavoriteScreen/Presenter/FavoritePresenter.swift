//
//  FavoritePresenter.swift
//  HalykStocks
//
//  Created by Даурен on 01.06.2022.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol FavoritePresenterProtocol {
    var view: FavoriteViewProtocol? { get set }
    var favCount: Int { get }
    func loadView()
    func loadFavorites()
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
        startObservingFavNotifications()
        loadFavorites()
    }
    
    func loadFavorites() {
        let stocks = service.favoriteStocks()
        favStocks = stocks.map { StockModel(stock: $0) }
    }
    
    func model(for index: IndexPath) -> StockModelProtocol {
        favStocks[index.row]
    }
}

extension FavoritePresenter: FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        loadFavorites()
        view?.updateView()
    }
}

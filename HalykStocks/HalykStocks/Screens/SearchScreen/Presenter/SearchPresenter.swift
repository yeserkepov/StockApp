//
//  SearchPresenter.swift
//  HalykStocks
//
//  Created by Даурен on 08.06.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath, isNew: Bool)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol SearchPresenterProtocol {
    var view: SearchViewProtocol? { get set }
    var favoriteStocksCount: Int { get }
    func loadView()
    func model(for index: IndexPath) -> StockModelProtocol
}

final class SearchPresenter: FavoritePresenterProtocol {
    weak var view: FavoriteViewProtocol?
    private var favStocks: [StockModelProtocol] = []
    private var service: StocksServiceProtocol
    
    init(service: StocksServiceProtocol) {
        self.service = service
        startObservingFavNotifications()
    }
    
    var favoriteStocksCount: Int {
        favStocks.count
    }
    
    func loadView() {
        loadFavorites()
        view?.updateView()
    }
    
    func loadFavorites() {
        favStocks = service.getFavoriteStocks()
    }
    
    func model(for index: IndexPath) -> StockModelProtocol {
        favStocks[index.row]
    }
}

extension SearchPresenter: FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        let old = favStocks
        favStocks = service.getFavoriteStocks()
        
        guard let id = notification.stockID else { return }
       
        if let index = favStocks.firstIndex(where: { $0.id == id }) {
            view?.updateCell(for: IndexPath(row: index, section: 0), isNew: true)
        } else if let index = old.firstIndex(where: { $0.id == id }){
            view?.updateCell(for: IndexPath(row: index, section: 0), isNew: false)
        }
    }
}


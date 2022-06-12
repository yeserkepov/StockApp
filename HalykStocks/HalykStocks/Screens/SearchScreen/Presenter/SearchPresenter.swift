//
//  SearchPresenter.swift
//  HalykStocks
//
//  Created by Даурен on 08.06.2022.
//

import Foundation

protocol SearchTextFieldDelegate: AnyObject {
    func textDidChange(with text: String?)
}

protocol SearchPresenterProtocol: SearchTextFieldDelegate {
    var view: StocksViewProtocol? { get set }
    var searchedStocksCount: Int { get }
    func loadView()
    func model(for index: IndexPath) -> StockModelProtocol
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: StocksViewProtocol?
    private var searchedStocks: [StockModelProtocol] = []
    private let service: SearchServiceProtocol
    
    init(service: SearchServiceProtocol) {
        self.service = service
        startObservingFavNotifications()
    }
    
    var searchedStocksCount: Int {
        searchedStocks.count
    }
    
    func loadView() {
        searchedStocks = service.getSearchedStocks(with: "")
        view?.updateView()
    }

    func model(for index: IndexPath) -> StockModelProtocol {
        searchedStocks[index.row]
    }
}

extension SearchPresenter: SearchTextFieldDelegate {
    func textDidChange(with text: String?) {
        searchedStocks = service.getSearchedStocks(with: text)
        view?.updateView()
    }
}

extension SearchPresenter: FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockID,
                let index = searchedStocks.firstIndex(where: { $0.id == id }) else { return }

        view?.updateCell(for: IndexPath(row: index, section: 0))
    }
}

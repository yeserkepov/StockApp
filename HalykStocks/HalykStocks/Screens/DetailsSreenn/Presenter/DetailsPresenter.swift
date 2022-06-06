//
//  DetailsPresenter.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import Foundation

protocol DetailsViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol DetailsPresenterProtocol {
    var view: DetailsViewProtocol? { get set }
    var favButtonSelected: Bool { get }
    func loadCharts()
    func favTapped()
    func dataConfigure() -> StockModelProtocol
}

final class DetailsPresenter: DetailsPresenterProtocol {
    var favButtonSelected: Bool {
        model.isFavorite
    }
    
    private let service: DetailsServicesProtocol
    //private var details: DetailModelProtocol?
    private let model: StockModelProtocol
    
    init(service: DetailsServicesProtocol, model: StockModelProtocol) {
        self.service = service
        self.model = model
    }
    
    weak var view: DetailsViewProtocol?
    
    func dataConfigure() -> StockModelProtocol  {
        model
    }
    
    func loadCharts() {
        view?.updateView(withLoader: true)
        service.getStockDetails(id: model.id) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let chart):
                //self?.details = DetailModel(detail: chart)
                print(chart.prices.map { $0.date })
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func favTapped() {
        model.favoriteTapped()
    }
}

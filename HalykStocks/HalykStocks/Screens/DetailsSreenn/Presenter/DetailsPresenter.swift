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
    func loadCharts()
    func dataConfigure() -> StockModelProtocol
}

final class DetailsPresenter: DetailsPresenterProtocol {
    private let service: DetailsServicesProtocol
    private var details: DetailModelProtocol?
    private let model: StockModelProtocol
    
    init(service: DetailsServicesProtocol, model: StockModelProtocol) {
        self.service = service
        self.model = model
    }
    
    // замутить диспатч для новой модели
    
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
                self?.details = DetailModel(detail: chart)
                /*
                print("PRICES - ", self?.details?.prices ?? 0.0)
                print("CAPS - ", self?.details?.market_caps ?? 0.0)
                print("VOLUMES - ", self?.details?.total_volumes ?? 0.0)
                 */
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
}

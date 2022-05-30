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
    func loadView()
}

final class DetailsPresenter: DetailsPresenterProtocol {
    private let service: DetailsServicesProtocol
    private var details: [DetailModelProtocol] = []
    
    init(service: DetailsServicesProtocol) {
        self.service = service
    }
    
    weak var view: DetailsViewProtocol?
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getStockDetails { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let details):
                print(details)
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
}

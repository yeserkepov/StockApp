//
//  StocksServices.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void))

    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void))

    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void))

    func getFavoriteStocks() -> [StockModelProtocol]
}

final class StocksService: StocksServiceProtocol {

    private let client: NetworkService
    private var stocksModels: [StockModelProtocol] = []

    // можно здесь создать проперти и для избранных
    init(client: NetworkService) {
        self.client = client
    }

    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void)) {

        if stocksModels.isEmpty {
            print("isEmpty")
            let serviceCompletion = serviceCompletion(with: completion)

            client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: serviceCompletion)
        } else {
            print("isNotEmpty")
            completion(.success(stocksModels))
        }

    }

    func getFavoriteStocks() -> [StockModelProtocol] {
        stocksModels.filter {$0.isFavorite}
    }

    private func serviceCompletion(with completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void) ) -> (Result<[StockResponse], NetworkError>) -> (Void) {
        { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.stocksModels = stocks.map{StockModel(stock: $0)}
                completion(.success(self?.stocksModels ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void)) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> (Void)) {
        getStocks(currency: "usd", completion: completion)
    }
}

//
//  StocksServices.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

//import Foundation
//
//fileprivate enum Constants {
//    static let currency = "usd"
//    static let count = "100"
//}
//
//protocol StocksServiceProtocol {
//    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
//    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
//    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
//    func getFavoriteStocks() -> [StockModelProtocol]
//}
//
//final class StocksService: StocksServiceProtocol {
//
//    private let client: NetworkService
//
//    private var favoriteStocks: [StockModelProtocol] = []
//
//    init(client: NetworkService) {
//        self.client = client
//    }
//
//    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
//        if favoriteStocks.isEmpty {
//            fetch(currency: currency, count: count, completion: completion)
//        } else {
//            completion(.success(favoriteStocks))
//        }
//    }
//
//    func getFavoriteStocks() -> [StockModelProtocol] {
//        favoriteStocks.filter { $0.isFavorite }
//    }
//
//    private func fetch(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
//        client.execute(with: StocksRouter.stocks(currency: currency, count: count)) { [weak self] (result: Result<[StockResponse], NetworkError>) in
//            switch result {
//            case .success(let stocks):
//                self?.favoriteStocks = stocks.map { StockModel(stock: $0) }
//                completion(.success(self?.favoriteStocks ?? []))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
//
//extension StocksServiceProtocol {
//    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
//        getStocks(currency: currency, count: Constants.count, completion: completion)
//    }
//
//    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
//        getStocks(currency: Constants.currency, completion: completion)
//    }
//}


import Foundation
typealias ServiceCompletion = (Result<[StockResponse], NetworkError>) -> (Void)
typealias ClientCompletion = (Result<[StockModelProtocol], NetworkError>) -> (Void)

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping ClientCompletion)

    func getStocks(currency: String, completion: @escaping ClientCompletion)

    func getStocks(completion: @escaping ClientCompletion)

    func getFavoriteStocks() -> [StockModelProtocol]
}

final class StocksService: StocksServiceProtocol {

    private let client: NetworkService
    private var stocksModels: [StockModelProtocol] = []

    // можно здесь создать проперти и для избранных
    init(client: NetworkService) {
        self.client = client
    }

    func getStocks(currency: String, count: String, completion: @escaping ClientCompletion) {

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

    private func serviceCompletion(with completion: @escaping ClientCompletion ) -> ServiceCompletion {
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
    // For stocks
    func getStocks(currency: String, completion: @escaping ClientCompletion) {
        getStocks(currency: currency, count: "100", completion: completion)
    }

    func getStocks(completion: @escaping ClientCompletion) {
        getStocks(currency: "usd", completion: completion)
    }
}

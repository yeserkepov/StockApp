//
//  StocksServices.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

protocol StocksServicesProtocol {
    func getStocks(currency: String, count: String, completion: @escaping(Result<[StockResponse], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping(Result<[StockResponse], NetworkError>) -> Void)
    func getStocks(completion: @escaping(Result<[StockResponse], NetworkError>) -> Void)
}

final class StocksService: StocksServicesProtocol {
    
    private let client: NetworkService
    
    internal init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockResponse], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
}

extension StocksServicesProtocol {
    func getStocks(currency: String, completion: @escaping(Result<[StockResponse], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping(Result<[StockResponse], NetworkError>) -> Void) {
        getStocks(currency: "usd", count: "100", completion: completion)
    }
}

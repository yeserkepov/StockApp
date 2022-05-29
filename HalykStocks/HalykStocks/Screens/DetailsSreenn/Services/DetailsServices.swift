//
//  StocksServices.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

protocol DetailsServicesProtocol {
    func getStockDetails(currency: String, days: String, interval: String, completion: @escaping(Result<[DetailsResponse], NetworkError>) -> Void)
    func getStockDetails(currency: String, completion: @escaping(Result<[DetailsResponse], NetworkError>) -> Void)
    func getStockDetails(completion: @escaping(Result<[DetailsResponse], NetworkError>) -> Void)
}

final class DetailsService: DetailsServicesProtocol {
    private let client: NetworkService
    internal init(client: NetworkService) {
        self.client = client
    }
    func getStockDetails(currency: String, days: String, interval: String, completion: @escaping(Result<[DetailsResponse], NetworkError>) -> Void) {
        client.execute(with: DetailsRouter.stockDetails(currency: currency, days: days, interval: interval), completion: completion)
    }
}

extension DetailsServicesProtocol {
    func getStockDetails(currency: String, completion: @escaping(Result<[DetailsResponse], NetworkError>) -> Void) {
        getStockDetails(currency: currency, days: "600", interval: "daily", completion: completion)
    }
    func getStockDetails(completion: @escaping(Result<[DetailsResponse], NetworkError>) -> Void) {
        getStockDetails(currency: "usd", days: "600", interval: "daily", completion: completion)
    }
}

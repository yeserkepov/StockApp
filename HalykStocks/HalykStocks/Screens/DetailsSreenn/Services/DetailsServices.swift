//
//  StocksServices.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

protocol DetailsServicesProtocol {
    func getStockDetails(id: String, currency: String, days: String, interval: String, completion: @escaping(Result<DetailsResponse, NetworkError>) -> Void)
    func getStockDetails(id: String, completion: @escaping(Result<DetailsResponse, NetworkError>) -> Void)
}

final class DetailsService: DetailsServicesProtocol {
    private let client: NetworkService
    internal init(client: NetworkService) {
        self.client = client
    }
    func getStockDetails(id: String, currency: String, days: String, interval: String, completion: @escaping(Result<DetailsResponse, NetworkError>) -> Void) {
        client.execute(with: DetailsRouter.stockDetails(id: id, currency: currency, days: days, interval: interval), completion: completion)
    }
}

extension DetailsServicesProtocol {
    func getStockDetails(id: String, completion: @escaping(Result<DetailsResponse, NetworkError>) -> Void) {
        getStockDetails(id: id, currency: "usd", days: "360", interval: "daily", completion: completion)
    }
}

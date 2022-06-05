//
//  StocksServices.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//


//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100

import Foundation

enum StocksRouter: Router {
    
    case stocks(currency: String, count: String)
    
    var baseUrl: String {
        "https://api.coingecko.com/api"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/v3/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        }
    }
}

protocol StocksServicesProtocol {
    func getStocks(currency: String, count: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void)
}

extension StocksServicesProtocol {
    func getStocks(currency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: "usd", count: "100", completion: completion)
    }
}

final class StocksService: StocksServicesProtocol {
    
    private let client: NetworkService
    
    internal init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
}

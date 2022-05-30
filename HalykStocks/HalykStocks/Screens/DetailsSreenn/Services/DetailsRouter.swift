//
//  StockRouter.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

//https://api.coingecko.com/api/v3/coins/%5BID%5D/market_chart?vs_currency=usd&days=60&interval=daily

import Foundation

enum DetailsRouter: Router {
    
    case stockDetails(currency: String, days: String, interval: String)
    
    var baseUrl: String {
        "https://api.coingecko.com/api"
    }
    
    var path: String {
        switch self {
        case .stockDetails:
            return "/v3/coins/bitcoin/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stockDetails:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stockDetails(let currency, let days, let interval):
            return ["vs_currency": currency, "days": days, "interval": interval]
        }
    }
}

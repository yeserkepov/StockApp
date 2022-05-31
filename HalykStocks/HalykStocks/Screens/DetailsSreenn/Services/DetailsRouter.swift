//
//  StockRouter.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

// нужно
// https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=60&interval=daily

// получаю
// https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=60&interval=daily

import Foundation

enum DetailsRouter: Router {
    
    // в кейс прокинуть параметр с id?
    case stockDetails(id: String, currency: String, days: String, interval: String)
    
    var baseUrl: String {
        "https://api.coingecko.com/api"
    }
    
    var path: String {
        switch self {
        case .stockDetails(let id, _, _, _):
            // как передать ID?
            return "/v3/coins/\(id)/market_chart"
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
        case .stockDetails(_, let currency, let days, let interval):
            return ["vs_currency": currency, "days": days, "interval": interval]
        }
    }
}

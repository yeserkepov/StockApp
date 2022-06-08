//
//  StockModel.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import Foundation

struct DetailModel {
    let periods: [Period]
    
    struct Period {
        let name: String
        let prices: [Double]
    }
    
    static func build(from charts: DetailsResponse) -> DetailModel {
        return DetailModel(periods: [Period(name: "W", prices: charts.prices.map { $0.price }),
                                     Period(name: "M", prices: charts.prices.map { $0.price }),
                                     Period(name: "6M", prices: charts.prices.map { $0.price }),
                                     Period(name: "1Y", prices: charts.prices.map { $0.price })])
    }
}

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
        let yearPeriod = charts.prices.map {$0.price}
        
        return DetailModel(periods: [
                                    Period(name: "W", prices: yearPeriod.suffix(7)),
                                    Period(name: "M", prices: yearPeriod.suffix(30)),
                                    Period(name: "6M", prices: yearPeriod.suffix(180)),
                                    Period(name: "1Y", prices: yearPeriod)
                                    ])
    }
}

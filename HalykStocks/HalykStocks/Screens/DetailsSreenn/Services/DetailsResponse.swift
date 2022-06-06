//
//  Stock.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

struct DetailsResponse: Decodable {
    let prices: [Price]
    let market_caps: [[Double]]
    let total_volumes: [[Double]]
    
    struct Price: Decodable {
        let date: Date
        let price: Double
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let array = try container.decode([Double].self)
            
            guard let time = array[safe: 0],
                   let price = array[safe: 1] else { throw NSError() }
            
            self.price = price
            self.date = Date(timeIntervalSince1970: time)
        }
    }
}

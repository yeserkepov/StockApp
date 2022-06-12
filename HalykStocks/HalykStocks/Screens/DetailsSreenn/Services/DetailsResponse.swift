//
//  Stock.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

struct DetailsResponse: Decodable {
    let prices: [Value]
    
    struct Value: Decodable {
        let date: Date
        let price: Double
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let array = try container.decode([Double].self)
            
            guard let date = array[safe: 0],
                  let price = array[safe: 1] else {
                throw NSError(domain: "Bad model from json", code: 500, userInfo: nil)
            }
            
            self.date = Date(timeIntervalSince1970: TimeInterval(date/1000))
            self.price = price
        }
    }
}


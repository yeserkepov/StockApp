//
//  Stock.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

struct DetailsResponse: Decodable {
    let prices: [[Double]]
    let market_caps: [[Double]]
    let total_volumes: [[Double]]
}
//
//enum CodingKeys: String, CodingKey {
//    case prices
//    case marketCaps = "market_caps"
//    case totalVolumes = "total_volumes"
//}

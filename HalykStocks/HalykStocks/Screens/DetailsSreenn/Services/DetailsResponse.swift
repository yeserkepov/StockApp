//
//  Stock.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import Foundation

struct DetailsResponse: Decodable {
    let prices, marketCaps, totalVolumes: [[Double]]
}

enum CodingKeys: String, CodingKey {
    case prices
    case marketCaps = "market_caps"
    case totalVolumes = "total_volumes"
}

//struct DetailsResponse: Codable {
//    let prices: [Price]
//}
//
//struct Price: Codable {
//    let date: Date
//    let price: Double
//}
//
//extension Price {
//    public init(from decoder: Decoder) throws {
//        var unkeyedContainer = try decoder.unkeyedContainer()
//        let date = try unkeyedContainer.decode(UInt64.self).date
//        let price = try unkeyedContainer.decode(Double.self)
//        self.init(date: date, price: price)
//    }
//    public func encode(to encoder: Encoder) throws {
//        var unkeyedContainer = encoder.unkeyedContainer()
//        try unkeyedContainer.encode(date.unixEpochTime)
//        try unkeyedContainer.encode(price)
//    }
//}
//
//extension UInt64 {
//    var date: Date {
//        return Date(timeIntervalSince1970: TimeInterval(self)/1000)
//    }
//}
//extension Date {
//    var unixEpochTime: UInt64 {
//        return UInt64(timeIntervalSince1970*1000)
//    }
//}

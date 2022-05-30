//
//  StockModel.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import UIKit

protocol DetailModelProtocol {
    var prices: [[Double]] { get }
    var marketCaps: [[Double]] { get }
    var totalVolumes: [[Double]] { get }
    
//    var prices: [Price] { get }
}

final class DetailModel: DetailModelProtocol {
    private let detail: DetailsResponse
    
    init(detail: DetailsResponse) {
        self.detail = detail
    }
    
    var prices: [[Double]] {
        detail.prices
    }

    var marketCaps: [[Double]] {
        detail.marketCaps
    }

    var totalVolumes: [[Double]] {
        detail.totalVolumes
    }
//
//    var prices: [Price] {
//        detail.prices
//    }
}

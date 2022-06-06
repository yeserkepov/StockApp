////
////  StockModel.swift
////  HalykStocks
////
////  Created by Даурен on 28.05.2022.
////
//
//import UIKit
//
//protocol DetailModelProtocol {
//    var prices: [[Double]] { get }
//    var market_caps: [[Double]] { get }
//    var total_volumes: [[Double]] { get }
//}
//
//final class DetailModel: DetailModelProtocol {
//    private let detail: DetailsResponse
//    
//    init(detail: DetailsResponse) {
//        self.detail = detail
//    }
//    
//    var prices: [[Double]] {
//        detail.prices
//    }
//    
//    var market_caps: [[Double]] {
//        detail.market_caps
//    }
//    
//    var total_volumes: [[Double]] {
//        detail.total_volumes
//    }
//
//}

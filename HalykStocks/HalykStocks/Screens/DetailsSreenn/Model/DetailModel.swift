//
//  StockModel.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import UIKit

protocol DetailModelProtocol {
    let prices: [[Double]] { get }
}

final class DetailModel: DetailModelProtocol {
    private let detail: DetailsResponse
    
    init(detail: DetailsResponse) {
        self.detail = detail
    }
    
    var prices: String {
        detail.prices
    }
    
}

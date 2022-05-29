//
//  StockModel.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changePercentage: String { get }
    var changeColor: UIColor { get }
    
    var isFavorite: Bool { get set }
}

final class StockModel: StockModelProtocol {
    private let stock: StockResponse

    init(stock: StockResponse) {
        self.stock = stock
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol.uppercased()
    }
    
    var price: String {
        "\(stock.price.clean) $"
    }
    
    var change: String {
        "\(floor(stock.change * 10000)/10000)"
    }
    
    var changePercentage: String {
        "(\(stock.changePercentage.clean) %)"
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .stocksDeltaGreen : .stocksDeltaRed
    }
    
    var isFavorite: Bool = false
}

//
//  SearchService.swift
//  HalykStocks
//
//  Created by Даурен on 10.06.2022.
//

import Foundation

protocol SearchServiceProtocol {
    func getSearchedStocks(with text: String?) -> [StockModelProtocol]
}

final class SearchService: SearchServiceProtocol {
    private let service: StocksServiceProtocol
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    func getSearchedStocks(with search: String?) -> [StockModelProtocol] {
        guard let search = search, !search.isEmpty else { return [] }
        
        return service.getAllStocks().filter {$0.symbol.lowercased().contains(search.lowercased())}
    }
    
}

//
//  FavoriteService.swift
//  HalykStocks
//
//  Created by Даурен on 01.06.2022.
//

import Foundation

protocol FavoriteServiceProtocol {
    func save(stocks: StockResponse)
    func remove(stocks: StockResponse)
    func isFavorite(for id: String) -> Bool
    func favoriteStocks() -> [StockResponse]
}

final class FavoriteService: FavoriteServiceProtocol {
    private lazy var path: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("favorites")
    }()
    
    private lazy var favArray: [StockResponse] = {
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([StockResponse].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }()
    
    func favoriteStocks() -> [StockResponse] {
        favArray
    }
    
    func save(stocks: StockResponse) {
        favArray.append(stocks)
        updateRepo(id: stocks.id)
    }
    
    func remove(stocks: StockResponse) {
        if let index = favArray.firstIndex(where: {$0.id == stocks.id}) {
            favArray.remove(at: index)
            updateRepo(id: stocks.id)
        }
    }
    
    func isFavorite(for id: String) -> Bool {
        favArray.contains(where: {$0.id == id})
    }
    
    private func updateRepo(id: String) {
        do {
            let data = try JSONEncoder().encode(favArray)
            try data.write(to: path)
            NotificationCenter.default.post(name: NSNotification.Name.favoriteNotifications,
                                                object: nil,
                                                userInfo: ["id" : id])
            print(data)
        } catch  {
            print(error.localizedDescription)
        }
    }
}

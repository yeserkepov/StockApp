//
//  FavoriteService.swift
//  HalykStocks
//
//  Created by Даурен on 01.06.2022.
//

import Foundation

protocol FavoriteServiceProtocol {
    func save(with id: StockResponse)
    func remove(with id: StockResponse)
    func isFavorite(for id: String) -> Bool
    func model() -> [StockResponse]
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
    
    func model() -> [StockResponse] {
        favArray
    }
    
    func save(with id: StockResponse) {
        favArray.append(id)
        updateRepo()
    }
    
    func remove(with id: StockResponse) {
        if let index = favArray.firstIndex(where: {$0.id == id.id}) {
            favArray.remove(at: index)
            updateRepo()
        }
    }
    
    func isFavorite(for id: String) -> Bool {
        favArray.contains(where: {$0.id == id})
    }
    
    private func updateRepo() {
        do {
            let data = try JSONEncoder().encode(favArray)
            try data.write(to: path)
            print(data)
        } catch  {
            print(error.localizedDescription)
        }
    }
}

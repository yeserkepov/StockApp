//
//  FavoriteService.swift
//  HalykStocks
//
//  Created by Даурен on 01.06.2022.
//

import Foundation

protocol FavoriteServiceProtocol {
    func save(stocks: String)
    func remove(stocks: String)
    func isFavorite(for id: String) -> Bool
}

final class FavoriteService: FavoriteServiceProtocol {
    private lazy var path: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("favorite")
    }()
    
    private lazy var favArray: [String] = {
        do {
            let data = try Data(contentsOf: path)
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }()
    
    func save(stocks: String) {
        favArray.append(stocks)
        updateRepo(id: stocks)
    }
    
    func remove(stocks: String) {
        if let index = favArray.firstIndex(where: {$0 == stocks}) {
            favArray.remove(at: index)
            updateRepo(id: stocks)
        }
    }
    
    func isFavorite(for id: String) -> Bool {
        favArray.contains(where: {$0 == id})
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

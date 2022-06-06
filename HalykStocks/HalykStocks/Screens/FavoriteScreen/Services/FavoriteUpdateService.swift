//
//  FavoriteUpdateService.swift
//  HalykStocks
//
//  Created by Даурен on 05.06.2022.
//

import Foundation

@objc protocol FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification)
}

extension FavoriteUpdateServiceProtocol {
    func startObservingFavNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setFavorite),
                                               name: NSNotification.Name.favoriteNotifications,
                                               object: nil)
    }
}

extension NSNotification.Name {
    static let favoriteNotifications = NSNotification.Name("favorite")
}

extension Notification {
    var stockID: String? {
        guard let userInfo = userInfo,
              let id = userInfo["id"] as? String else { return nil }
        
        return id
    }
}

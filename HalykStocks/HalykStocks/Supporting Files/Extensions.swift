//
//  Extensions.swift
//  HalykStocks
//
//  Created by Даурен on 26.05.2022.
//

enum CustomFont: String {
    case moserratBold = "Montserrat-Bold"
    case moserratMedium = "Montserrat-Medium"
}

import Foundation
import UIKit

extension UIFont {
    static func customFont(name: CustomFont, size: CGFloat) -> UIFont {
        let font = UIFont(name: name.rawValue, size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIColor {
    static let stocksGrey = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
    static let stocksWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let stocksDeltaGreen = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
}

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}

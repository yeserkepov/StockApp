//
//  UIFont+Ext.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

enum CustomFont: String {
    case moserratBold = "Montserrat-Bold"
    case moserratMedium = "Montserrat-Medium"
}

import UIKit

extension UIFont {
    static func customFont(name: CustomFont, size: CGFloat) -> UIFont {
        UIFont(name: name.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

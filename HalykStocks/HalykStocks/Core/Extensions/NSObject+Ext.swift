//
//  NSObject+Ext.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}

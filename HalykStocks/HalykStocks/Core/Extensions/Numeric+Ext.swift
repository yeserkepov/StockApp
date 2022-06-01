//
//  Extensions.swift
//  HalykStocks
//
//  Created by Даурен on 28.05.2022.
//

import Foundation

extension Double {
    private func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    private var isInteger: Bool {
        rounded() == self
    }
    
    var clean: String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        }  else {
            return String(floor(self * 10000)/10000)
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(for: self) ?? ""
    }
}

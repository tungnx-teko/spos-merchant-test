//
//  Double+.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

extension Double {
    
    func toCurrencyString() -> String? {
        let formatter = NumberFormatter()
        if #available(iOS 11.0, *) {
            formatter.numberStyle = .currency
        } else {
            formatter.numberStyle = .currencyAccounting
        }
        formatter.locale = Locale(identifier: "vi_VN")
        let result = formatter.string(from: NSNumber(value: self)) ?? ""
        let spaceOfApple = " "
        return result.replacingOccurrences(of: spaceOfApple, with: "")
    }
    
}

extension Int {
    
    func toCurrencyString() -> String? {
        return Double(self).toCurrencyString()
    }
    
}

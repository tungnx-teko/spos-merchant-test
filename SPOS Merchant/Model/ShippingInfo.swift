//
//  ShippingInfo.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct ShippingInfo: Encodable {
    var phone: String = "0987654321"
    var wardId: String = "010502"
    var provinceId: String = "01"
    var address: String = "PeakView Tower"
    var country: String = "84"
    var note: String = ""
    var name: String = "Test Merchant"
    var email: String = "trang.nt@teko.vn"
    var districtId: String = "0105"
    var fullAddress: String = "36 Hoang Cau, Dong Da, Hanoi"
}

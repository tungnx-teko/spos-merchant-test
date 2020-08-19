//
//  OrderCustomer.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct OrderCustomer: Encodable {
    var address: String = "PeakView towerrrr"
    var is_deleted: Bool = false
    var business_type: Int = 0
    var fullAddress: String = "36 Hoang Cau"
    var wardId: String = "010502"
    var name: String = "Nguyen Thi Trang Test"
    var id: Int = 29146
    var scope: Int = 0
    var provinceId: String = "01"
    var asiaCrmId: String = "39146"
    var phone: String = "0987654321"
    var districtId: String = "0105"
    var is_company: Bool = false
}

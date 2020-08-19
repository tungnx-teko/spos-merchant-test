//
//  OrderPayload.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct OrderPayload: Encodable {
    var grandTotal: Int
    var customer: OrderCustomer = OrderCustomer()
    var channelType: String = "online"
    var discountInfo: [String] = []
    var channelId: Int
    var terminalCode: String
    var channelCode: String
    var shippingInfo: ShippingInfo = ShippingInfo()
    var delivery: Bool = true
    var items: [OrderItem]
    var promotions: [String] = []
}

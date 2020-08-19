//
//  OrderResponse.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

//{"code": 0, "data": {"id": "7e43e35f-adea-4054-88a5-5ca1c672b424", "code": "O20818SAAI", "state": "WAITING_FOR_PAYMENT_CONFIRMATION", "childOrders": [{"id": "03b36094-7c84-4d40-a8a4-59aa42cb31aa", "code": "20818SAA16", "grandTotal": 284000.0}], "grandTotal": 284000.0, "predictCancelAt": "2020-08-18T04:58:58.335158", "items": [{"sku": "1600596", "name": "Chuot khong day", "displayName": "Chuot khong day", "quantity": 1, "uom": null, "bizType": "Biz", "vatRate": 10.0, "unitPrice": 284000.0, "price": 284000.0, "sellerId": 1, "unitPriceBeforeTax": 258182.0, "priceBeforeTax": 258182.0, "rowTotal": 284000.0, "lineItemId": "37DAE1CA-3584-4C1E-B71A-3720E63558D4", "unitDiscount": 0, "discountReason": null, "unitAdd": 0, "addReason": null, "warranty": 0, "parentSku": null, "taxOutCode": "10", "serial": null, "sourceLocation": null, "remainQuantity": 1, "deltaDiscount": 0.0}], "payments": [], "remainPayment": 284000.0, "serviceFee": null}, "error": null}

struct OrderResponse: Decodable {
    var code: Int
    var data: Order
}

struct Order: Decodable {
    var id: String
    var code: String
    var state: String
    var grandTotal: Double
}

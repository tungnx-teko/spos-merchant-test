//
//  Token.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct Token: Decodable {
    var access_token: String
    var expires_in: Int
    var refresh_token: String
    var scope: String
    var token_type: String
}

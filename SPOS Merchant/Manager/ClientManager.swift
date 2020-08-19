//
//  ClientManager.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

class ClientManager {
    
    public static let shared = ClientManager()
    
    private init() {}
    
    var terminalCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "TERMINAL_CODE")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "TERMINAL_CODE")
        }
    }
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "ACCESS_TOKEN")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ACCESS_TOKEN")
        }
    }
    
    var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "REFRESH_TOKEN")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "REFRESH_TOKEN")
        }
    }
    
}

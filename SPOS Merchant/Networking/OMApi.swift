//
//  OMApi.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import Moya
import Janus

enum OMApi {
    case create(params: [String: Any])
}

extension OMApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://orders.stage.tekoapis.net")!
    }
    
    var path: String {
        switch self {
        case .create:
            return "/command/market-orders"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .create(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding())
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(AuthManager.shared.credential?.accessToken ?? "")"]
//        return ["Authorization": "Bearer \(ClientManager.shared.accessToken ?? "")"]
    }
    
}

class OrderManager {
    
    static let shared = OrderManager()
    
    private let provider = MoyaProvider<OMApi>()
    
    private init() {}
    
    func createOrder(params: [String: Any], completion: @escaping (Order?, Error?) -> ()) {
        provider.request(.create(params: params)) { (result) in
            switch result {
            case .success(let response):
                let data = response.data
                let jsonString = String(data: data, encoding: .utf8)
                print(jsonString!)
                let order = try? JSONDecoder().decode(OrderResponse.self, from: data)
                completion(order?.data, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
}

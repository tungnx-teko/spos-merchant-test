//
//  AuthManager.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import Moya

enum AuthApi {
    case getToken(phone: String, pin: String)
}

extension AuthApi: TargetType {
    
    static let refreshToken = "d5dbe86263a6e7a02863b5989219ed8cc691a104c19e6704d2a89597f3ec120d"
    
    var baseURL: URL {
        return URL(string: "https://oauth.stage.tekoapis.net/oauth/token")!
    }
    
    var path: String {
        return "/oauth/token"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getToken(let phone, let pin):
            var params = [String: Any]()
            params["client_id"] = "b631a62cea4e48a180f6a866c9aa7796"
            params["grant_type"] = "passwordless"
            params["phone_number"] = phone
            params["code"] = pin
            params["scope"] = "openid profile om ps catalog ppm us sellers page_builder iam_identity"
            let string = params.map { (key, value) in "\(key)=\(value)"}.joined(separator: "&")
            let data = string.data(using: .utf8)!
            return .requestData(data)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
}
//
//class AuthManager {
//    
//    static let shared = AuthManager()
//    
//    private let provider = MoyaProvider<AuthApi>()
//    
//    private init() {}
//    
//    func getToken(phone: String, pin: String, completion: @escaping (Token?) -> ()) {
//        provider.request(.getToken(phone: phone, pin: pin)) { response in
//            switch response {
//            case .success(let res):
//                let data = res.data
//                print(String(data: data, encoding: .utf8)!)
//                completion(nil)
//            case .failure:
//                completion(nil)
//            }
//        }
//    }
//    
//}

//
//  IdApi.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation
import Moya

enum IdApi {
    case submitPhone(phone: String)
}

extension IdApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://identity.stage.tekoapis.net")!
    }
    
    var path: String {
        return "/api/v1/passwordless/send"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .submitPhone(let phone):
            let params = ["phone_number": phone]
            return .requestCompositeParameters(bodyParameters: params, bodyEncoding: JSONEncoding(), urlParameters: ["client_id": "b631a62cea4e48a180f6a866c9aa7796"])
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }

}

class IdService {
    
    static let shared = IdService()
    
    private let provider = MoyaProvider<IdApi>()
    
    private init() {}
    
    func sendOtp(phone: String, completion: @escaping (Bool) -> ()) {
        provider.request(.submitPhone(phone: phone)) { response in
            switch response {
            case .success(let res):
                let data = res.data
                print(String(data: data, encoding: .utf8)!)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}

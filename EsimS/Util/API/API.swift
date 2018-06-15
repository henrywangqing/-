//
//  AccountAPI.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation
import Moya
import SVProgressHUD

// 请求成功的回调
typealias successCallback = (_ result: NSDictionary) -> Void
// 请求失败的回调
typealias failureCallback = (_ error: Any) -> Void

let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<APIService>.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 20
        done(.success(request))
    } catch {
        return
    }
}
let provider = MoyaProvider<APIService>(requestClosure: requestTimeoutClosure)


// 网络请求结构体
struct APITool {
    
    // 发送网络请求
    static func request(
        target: APIService,
        success: @escaping successCallback,
        failure: @escaping failureCallback
        ) {
        
        provider.request(target) { result in
            
            
            switch result {
                
            case let .success(moyaResponse):
                SVProgressHUD.dismiss()
                
                do {
                    let data = try moyaResponse.mapJSON()
                   
                    if let dic = data as? NSDictionary,
                       let code = dic["code"] as? Int,
                       code == 200,
                       let successResult = dic["data"] as? NSDictionary
                        {
                        success(successResult)
                        return
    
                    }
                    failure(data)
                    if let dic = data as? NSDictionary,
                        let msg = dic["error"] as? String {
                        SVProgressHUD.showError(withStatus: msg)
                    }
                } catch {
                    let error = MoyaError.jsonMapping(moyaResponse)
                    failure(error)
                    SVProgressHUD.showError(withStatus: error.errorDescription)
                }
            case let .failure(error):
                SVProgressHUD.dismiss()
                failure(error)
                SVProgressHUD.showError(withStatus: error.errorDescription)
            }
        }
    }
}

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum APIService {
    case login(username: String, password: String)
    case logout
    case inquiryCard(simNoList:[Any], sim_type: Int, month: Int, pageNumber:Int, pageSize:Int)
    case submitOrder(simNoList:[Any], month: Int)
    case confirmOrder(simNoList:[Any], sim_type:Int, month: Int
        , order_no: String, sum_fee: Double, pay_type: Int, pay_status: Bool)
    case firstPage
}

extension APIService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://120.79.199.18:8081/api/")!
    }
//    192.168.1.176  120.79.199.18
    public var path: String {
        switch self {
        case .login:
            return "login/login"
        case .logout:
            return "APIService/logout"
        case .inquiryCard( _, _, _, _, _):
            return "app/chargeList"
        case .submitOrder( _, _):
            return "app/orderInfo"
        case .confirmOrder( _, _, _, _, _, _, _):
            return "app/createOrder"
            
        case .firstPage:
            return "app/getSimStaticInfo"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .logout:
            return .post
        case .inquiryCard( _, _, _, _, _):
            return .post
        case .submitOrder( _, _):
            return .post
        case .confirmOrder( _, _, _, _, _, _, _):
            return .post
        case .firstPage:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .login(let username, let password):
            
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
            
        case .logout:
            return .requestPlain
        case .inquiryCard(let simNoList, let sim_type, let month, let pageNumber, let pageSize):
            print(["simNoList": simNoList, "sim_type": sim_type, "month": month, "pageNumber": pageNumber, "pageSize": pageSize])
            return .requestParameters(parameters: ["simNoList": simNoList, "sim_type": sim_type, "month": month, "pageNumber": pageNumber, "pageSize": pageSize], encoding: JSONEncoding.default)
        case .submitOrder(let simNoList, let month):
            return .requestParameters(parameters: ["simNoList": simNoList, "month": month], encoding: JSONEncoding.default)
        case .confirmOrder(let simNoList, let sim_type, let month, let order_no, let sum_fee, let pay_type, let pay_status):
            return .requestParameters(parameters: ["simNoList": simNoList, "sim_type": sim_type, "month": month, "order_no": order_no, "sum_fee": sum_fee, "pay_type": pay_type, "pay_status": pay_status], encoding: JSONEncoding.default)
        case .firstPage:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-type": "application/json"]
        default:
            return ["Content-type": "application/json", "X-Token": DataManager.currentAccount().token]
        }
    }
}










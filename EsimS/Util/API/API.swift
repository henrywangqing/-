//
//  AccountAPI.swift
//  EsimS
//
//  Created by 王庆 on 2018/5/10.
//  Copyright © 2018年 iotwoods. All rights reserved.
//

import Foundation
import Moya

// 请求成功的回调
typealias successCallback = (_ result: Any) -> Void
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
                ProgressHUD.dismiss()
                
                do {
                    let data = try moyaResponse.mapJSON()
                    
                    if let dic = data as? NSDictionary,
                       let code = dic["code"] as? Int,
                       code == 200,
                       let successResult = dic["data"]
                        {
                        success(successResult)
                        return
    
                    }
                    else if let dic = data as? NSDictionary,
                        let message = dic["message"] as? String,
                        let code = dic["code"] as? Int {
                        manageError(code: code, message: message)
                    }
                    failure(data)
                } catch {
                    let error = MoyaError.jsonMapping(moyaResponse)
                    ProgressHUD.showError(withStatus: error.errorDescription)
                    failure(error)
                }
                break
            case let .failure(error):
                ProgressHUD.dismiss()
                ProgressHUD.showError(withStatus: error.errorDescription)
                failure(error)
                break
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
    case getInfo
    case logout(token: String)
    case getRenewedCardInfo(simNoList:[Any], sim_type: Int, month: Int, pageNumber:Int, pageSize:Int)
    case submitOrder(simNoList:[Any], month: Int)
    case confirmOrder(simNoList:[Any], order_id: String, sum_fee: Double, pay_type: Int, pay_status: Bool)
    case dashBoardInfo
    case singleCardInquiry(sim_no: String)
    case cardListInquiry(pageNumber: Int, pageSize: Int)
    case orderListInquiry(pageNumber: Int, pageSize: Int)
    case refreshCardInfo(iccid: String)
}

extension APIService: TargetType {
    
    public var baseURL: URL {
        return URL(string: host.online.rawValue)!
    }
// bema_test Bema_test123
    public var path: String {
        switch self {
        case .login:
            return "login/login"
        case .getInfo:
            return "user/getInfo"
        case .logout(_):
            return "login/logout"
        case .getRenewedCardInfo( _, _, _, _, _):
            return "app/chargeList"
        case .submitOrder( _, _):
            return "app/orderInfo"
        case .confirmOrder( _, _, _, _, _):
            return "app/createOrder"
        case .dashBoardInfo:
            return "app/dashBoardInfo"
        case .singleCardInquiry(_):
            return "utils/getSimTableExact"
        case .cardListInquiry(_, _):
            return "app/getSimTable"
        case .orderListInquiry(_, _):
            return "app/getOrderList"
        case .refreshCardInfo(_):
            return "app/refreshSimInfo"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getInfo:
            return .get
        case .logout(_):
            return .get
        case .getRenewedCardInfo( _, _, _, _, _):
            return .post
        case .submitOrder( _, _):
            return .post
        case .confirmOrder( _, _, _, _, _):
            return .post
        case .dashBoardInfo:
            return .get
        case .singleCardInquiry(_):
            return .get
        case .cardListInquiry(_, _):
            return .post
        case .orderListInquiry(_, _):
            return .post
        case .refreshCardInfo(_):
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case .getInfo:
            return .requestPlain
        case .logout(let token):
            return .requestParameters(parameters: ["token": token], encoding: URLEncoding.default)
        case .getRenewedCardInfo(let simNoList, let sim_type, let month, let pageNumber, let pageSize):
            return .requestParameters(parameters: ["simNoList": simNoList, "sim_type": sim_type, "month": month, "pageNumber": pageNumber, "pageSize": pageSize], encoding: JSONEncoding.default)
        case .submitOrder(let simNoList, let month):
            return .requestParameters(parameters: ["simNoList": simNoList, "month": month], encoding: JSONEncoding.default)
        case .confirmOrder(let simNoList, let order_id, let sum_fee, let pay_type, let pay_status):
            return .requestParameters(parameters: ["simNoList": simNoList, "order_id": order_id, "sum_fee": sum_fee, "pay_type": pay_type, "pay_status": pay_status], encoding: JSONEncoding.default)
        case .dashBoardInfo:
            return .requestPlain
        case .singleCardInquiry(let sim_no): 
            return .requestParameters(parameters: ["sim_no": sim_no], encoding: URLEncoding.default)
        case .cardListInquiry(let pageNumber, let pageSize):
            return .requestParameters(parameters: ["pageNumber": pageNumber, "pageSize": pageSize], encoding: JSONEncoding.default)
        case .orderListInquiry(let pageNumber, let pageSize):
            return .requestParameters(parameters: ["pageNumber": pageNumber, "pageSize": pageSize], encoding: JSONEncoding.default)
        case .refreshCardInfo(let iccid):
            return .requestParameters(parameters: ["iccid": iccid], encoding: JSONEncoding.default)
        }
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login, .singleCardInquiry(_):
            return ["Content-type": "application/json"]
        default:
            return ["Content-type": "application/json", "X-Token": DataManager.currentAccount().token]
        }
    }
}










//
//  NetworkTools.swift
//  Alamofire封装
//
//  Created by LXF on 2016/11/14.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import Alamofire

/// 定义枚举类型
enum RequestType: Int {
    case GET
    case POST
}

class NetworkTools: NSObject {
    static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        return tools
    }()
}

// MARK:- 封装请求方法
extension NetworkTools {
    // MARK: 请求JSON数据
    func requestData(methodType: RequestType, urlString: String, parameters: [String : AnyObject]?, finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        
        // 1.定义请求结果回调闭包
        let resultCallBack = { (response: DataResponse<Any>) in
            if response.result.isSuccess {
                finished(response.result.value as AnyObject?, nil)
            } else {
                finished(nil, response.result.error as NSError?)
            }
        }
        
        // 2.请求数据
        let httpMethod: HTTPMethod = methodType == .GET ? .get : .post
        request(urlString, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: resultCallBack)
    }
}




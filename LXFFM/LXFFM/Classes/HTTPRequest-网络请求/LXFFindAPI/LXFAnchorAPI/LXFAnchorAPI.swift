//
//  LXFAnchorAPI.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

let kLXFAnchorAPI = "http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.27"

class LXFAnchorAPI: NSObject {
    class func requestAnchorData(_ finished: @escaping (_ reslut: AnyObject? , _ error: NSError?)->()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kLXFAnchorAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}

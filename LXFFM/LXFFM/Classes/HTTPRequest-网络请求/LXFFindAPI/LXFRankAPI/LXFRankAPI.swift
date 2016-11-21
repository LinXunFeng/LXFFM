//
//  LXFRankAPI.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

let kLXFRankAPI = "http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.27"

class LXFRankAPI: NSObject {
    class func requestRank(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?)->()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kLXFRankAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}

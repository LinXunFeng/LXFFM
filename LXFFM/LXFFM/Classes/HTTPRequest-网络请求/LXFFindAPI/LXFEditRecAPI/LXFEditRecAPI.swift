//
//  LXFEditRecAPI.swift
//  LXFFM
//
//  Created by LXF on 2016/11/16.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let kEditRecomAPI = "http://mobile.ximalaya.com/mobile/discovery/v2/recommend/editor"

class LXFEditRecAPI: LXFBaseAPI {
    class func requestEditRecWith(page: NSInteger, _ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        var params: [String : AnyObject] = [String : AnyObject]()
        params["device"] = "iPhone" as AnyObject?
        params["pageId"] = page as AnyObject?
        params["pageSize"] = 20 as AnyObject?
        params["statEvent"] = "pageview/albumlist@小编推荐" as AnyObject?
        params["statModule"] = "小编推荐_更多" as AnyObject?
        params["statPage"] = "tab@发现_推荐" as AnyObject?
        params["version"] = "5.4.27" as AnyObject?
        
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kEditRecomAPI, parameters: params) { (result, error) in
            finished(result, error)
        }
    }
}

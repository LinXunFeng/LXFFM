//
//  LXFRadioAPI.swift
//  LXFFM
//
//  Created by LXF on 2016/11/20.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

let kLXFRadioAPI = "http://live.ximalaya.com/live-web/v4/homepage?device=iPhone"

class LXFRadioAPI: NSObject {
    class func requestRadioRecommend(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kLXFRadioAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}



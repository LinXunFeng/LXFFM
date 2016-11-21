//
//  LXFCateAPI.swift
//  LXFFM
//
//  Created by LXF on 2016/11/19.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

let kCategoryItemsAPI = "http://mobile.ximalaya.com/mobile/discovery/v2/categories?channel=ios-b1&code=43_110000_1100&device=iPhone&picVersion=13&scale=2&version=5.4.27"
let kCategoryFooterAPI = "http://adse.ximalaya.com/ting?appid=0&device=iPhone&name=find_banner&network=WIFI&operator=3&scale=2&version=5.4.27"

class LXFCateAPI: NSObject {
    /// 类别中的分类和banner下方的按钮
    class func requestCategory(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kCategoryItemsAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
    /// 发现栏目中得FootView的请求地址
    class func requestFootBanner(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kCategoryFooterAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}

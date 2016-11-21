//
//  LXFBaseAPI.swift
//  LXFFM
//
//  Created by LXF on 2016/11/16.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFBaseAPI: NSObject {
    var params: [String : AnyObject] {
        get{
            return ["iPhone" : "device" as AnyObject]
        }
    }
}

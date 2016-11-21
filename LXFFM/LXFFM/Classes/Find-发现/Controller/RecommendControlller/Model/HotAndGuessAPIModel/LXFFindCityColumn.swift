//
//  LXFFindCityColumn.swift
//  YYText
//
//  Created by LXF on 16/11/15
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindCityColumn: HandyJSON {

    var code: String?

    var title: String?

    var count: Int = 0

    var list: [LXFFindFeeDetailModel]?

    var hasMore: Bool = false

    var contentType: String?
    
    required init() {}
}

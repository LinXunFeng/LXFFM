//
//  LXFFindHotRecommendsList.swift
//  LXFFM
//
//  Created by LXF on 16/11/16
//  Copyright (c) LXF. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindHotRecommendsList: HandyJSON {

    var hasMore: Bool = false

    var isPaid: Bool = false

    var contentType: String?

    var title: String?

    var isFinished: Bool = false

    var categoryId: Int = 0

    var count: Int = 0

    var list: [LXFFindFeeDetailModel]?

    var categoryType: Int = 0

    var filterSupported: Bool = false
    
    required init() {}
}

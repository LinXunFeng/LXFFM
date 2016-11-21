//
//  LXFFindRandList.swift
//  LXFFM
//
//  Created by LXF on 16/11/21
//  Copyright (c) LXF. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindRandList: HandyJSON {

    var totalCount: Int = 0

    var firstId: Int = 0

    var pageSize: Int = 0

    var title: String?

    var firstKResults: [LXFFindRandFirstkresults]?

    var top: Int = 0

    var period: Int = 0

    var rankingRule: String?

    var calcPeriod: String?

    var orderNum: Int = 0

    var pageId: Int = 0

    var maxPageId: Int = 0

    var rankingListId: Int = 0

    var list: [String]?

    var coverPath: String?

    var subtitle: String?

    var contentType: String?

    var ret: Int = 0

    var firstTitle: String?

    var categoryId: Int = 0

    var key: String?
    
    required init() {}
}

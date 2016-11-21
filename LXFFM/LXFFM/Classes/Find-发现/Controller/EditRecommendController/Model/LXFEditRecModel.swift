//
//  LXFEditRecModel.swift
//  SDWebImage
//
//  Created by LXF on 16/11/16
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

import UIKit
import HandyJSON

class LXFEditRecModel: HandyJSON {

    var pageId: Int = 0

    var pageSize: Int = 0

    var totalCount: Int = 0

    var maxPageId: Int = 0

    var msg: String?

    var list: [LXFEditRecModelList]?

    var ret: Int = 0

    required init() {}
}

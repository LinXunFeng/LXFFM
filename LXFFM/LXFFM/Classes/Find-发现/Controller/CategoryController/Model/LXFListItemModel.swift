//
//  LXFListItemModel.swift
//  SDWebImage
//
//  Created by LXF on 16/11/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

import UIKit
import HandyJSON

class LXFListItemModel: HandyJSON {

    var ID: Int = 0

    var orderNum: Int = 0

    var filterSupported: Bool = false

    var isChecked: Bool = false

    var isFinished: Bool = false

    var contentType: String?

    var isPaid: Bool = false

    var title: String?

    var selectedSwitch: Bool = false

    var categoryType: Int = 0

    var coverPath: String?

    var name: String?
   
    required init() {}
}

//
//  LXFAnchorSectionModel.swift
//  LXFFM
//
//  Created by LXF on 16/11/21
//  Copyright (c) LXF. All rights reserved.
//

import UIKit
import HandyJSON

class LXFAnchorSectionModel: HandyJSON {

    var ID: Int = 0

    var title: String?
    
    var name: String?

    var displayStyle: Int = 0

    var list: [LXFAnchorSectionList]?
    
    required init() {}
}

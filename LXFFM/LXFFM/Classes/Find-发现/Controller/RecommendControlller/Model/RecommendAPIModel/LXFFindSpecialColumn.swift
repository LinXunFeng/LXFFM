//
//  LXFFindSpecialColumn.swift
//  LXFFM
//
//  Created by LXF on 16/11/14
//  Copyright (c) LXF. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindSpecialColumn: HandyJSON {

    var title: String?

    var list: [LXFFindSpecialColumnDetail]?

    var hasMore: Bool = false

    var ret: Int = 0
    
    required init() {}
}

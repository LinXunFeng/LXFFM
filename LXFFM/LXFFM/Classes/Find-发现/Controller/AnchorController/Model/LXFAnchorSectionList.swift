//
//  LXFAnchorSectionList.swift
//  LXFFM
//
//  Created by LXF on 16/11/21
//  Copyright (c) LXF. All rights reserved.
//

import UIKit
import HandyJSON

class LXFAnchorSectionList: HandyJSON {

    var smallLogo: String?

    var uid: Int = 0

    var nickname: String?

    var isVerified: Bool = false

    var middleLogo: String?

    var largeLogo: String?

    var followersCounts: Int = 0

    var verifyTitle: String?

    var tracksCounts: Int = 0

    var personDescribe: String?
    
    required init() {}
}

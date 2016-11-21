//
//  LXFRadioLive.swift
//  YYText
//
//  Created by LXF on 16/11/20
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

import UIKit
import HandyJSON

class LXFRadioLive: HandyJSON {

    var playUrl: LXFRadioPlayurl?

    var coverSmall: String?

    var programName: String?

    var ID: Int = 0

    var programScheduleId: Int = 0

    var playCount: Int = 0

    var coverLarge: String?

    var fmUid: Int = 0

    var name: String?

    var programId: Int = 0
    
    required init() {}
}

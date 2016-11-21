//
//  LXFFindLive.swift
//  YYText
//
//  Created by LXF on 16/11/15
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindLive: HandyJSON {

    var ID: Int = 0

    var onlineCount: Int = 0

    var endTs: Int = 0

    var remainMs: Int = 0

    var playCount: Int = 0

    var shortDescription: String?

    var startTs: Int = 0

    var scheduleId: Int = 0

    var chatId: Int = 0

    var coverPath: String?

    var name: String?

    var status: Int = 0
    
    required init() {}
}

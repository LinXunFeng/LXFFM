//
//  LXFFindDiscoveryColumnsList.swift
//  YYText
//
//  Created by LXF on 16/11/15
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindDiscoveryColumnsList: HandyJSON {

    var subtitle: String?

    var coverPath: String?

    var contentType: String?

    var title: String?

    var enableShare: Bool = false

    var isExternalUrl: Bool = false

    var properties: LXFFindDiscoveryColumnsProperties?

    var sharePic: String?

    var url: String?
    
    required init() {}
}

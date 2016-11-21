//
//  LXFFindFeeDetailModel.swift
//  LXFFM
//
//  Created by LXF on 2016/11/16.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import HandyJSON

class LXFFindFeeDetailModel: HandyJSON {
    
    var title: String?
    
    var tags: String?
    
    var serialState: Int = 0
    
    var nickname: String?
    
    var coverMiddle: String?
    
    var playsCounts: Int = 0
    
    var intro: String?
    
    var isPaid: Bool = false
    
    var commentsCount: Int = 0
    
    var albumId: Int = 0
    
    var ID: Int = 0
    
    var coverSmall: String?
    
    var coverLarge: String?
    
    var uid: Int = 0
    
    var tracks: Int = 0
    
    var trackTitle: String?
    
    var priceTypeId: Int = 0
    
    var isFinished: Int = 0
    
    var trackId: Int = 0
    
    var provider: String?
    
    var albumCoverUrl290: String?
    
    required init() {}
}

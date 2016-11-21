//
//  LXFFindRadioViewModel.swift
//  LXFFM
//
//  Created by LXF on 2016/11/20.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


enum LXFFindRadioTelCellStyle: NSInteger {
    case LXFFindRadioTelCellStyleHidden = 0 // 隐藏
    case LXFFindRadioTelCellStyleShow   = 1 // 显示
}

class LXFFindRadioViewModel: NSObject {

    // MARK:- 定义属性
    var categories: Array<LXFRadioCategoryItem?> = []
    var localRadios: Array<LXFRadioLive?> = []
    var topRadios: Array<LXFRadioLive?> = []
    var location: String?
    var style: LXFFindRadioTelCellStyle = .LXFFindRadioTelCellStyleHidden
    
    // MARK:- 数据更新回调
    typealias AddBlock = ()->Void;
    var updateBlock = AddBlock?()
}

// MARK:- 调用API
extension LXFFindRadioViewModel {
    func refreshDataSource() {
        // 加载 LXFRadioAPI
        LXFRadioAPI.requestRadioRecommend { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                
                self.location = json["data"]["location"].stringValue
                
                if let categories = JSONDeserializer<LXFRadioCategoryItem>.deserializeModelArrayFrom(json: json["data"]["categories"].description) {
                    self.categories = categories
                }
                
                if let localRadios = JSONDeserializer<LXFRadioLive>.deserializeModelArrayFrom(json: json["data"]["localRadios"].description) {
                    self.localRadios = localRadios
                }
                
                if let topRadios = JSONDeserializer<LXFRadioLive>.deserializeModelArrayFrom(json: json["data"]["topRadios"].description) {
                    self.topRadios = topRadios
                }
                
                // 更新tableView数据
                self.updateBlock?()
            }
        }
    }
}

// MARK:- tableView数据
extension LXFFindRadioViewModel {
    
    func numberOfRowIn(section: NSInteger) -> NSInteger {
        // 参数定义在Controller中
        if section == kSectionTel { // 电台section
            return 1
        } else if section == kSectionLocal {    // 本地section
            return self.localRadios.count
        } else if section == kSectionTop && topRadios.count >= 3 {
            return 3
        } else {
            return topRadios.count
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        if indexPath.section == kSectionTel {
            if style == .LXFFindRadioTelCellStyleHidden {
                return 200
            } else {
                return 293
            }
        } else {
            return 85.0
        }
    }
    
    func heightForHeaderIn(section: NSInteger) -> CGFloat {
        if section == kSectionTel {
            return 0.01
        } else {
            return 40.0
        }
    }
    
    func heightForFooterIn(section: NSInteger) -> CGFloat {
        return 10.0
    }
}


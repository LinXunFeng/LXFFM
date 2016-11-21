//
//  LXFSubFindFactory.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

enum LXFSubFindType {
    case LXFSubFindTypeRecommend    // 推荐
    case LXFSubFindTypeCategory     // 分类
    case LXFSubFindTypeRadio        // 广播
    case LXFSubFindTypeRand         // 榜单
    case LXFSubFindTypeAnchor       // 主播
    case LXFSubFindTypeUnkown       // 未知
}

class LXFSubFindFactory: NSObject {
    // MARK:- 生成子控制器
    class func subFindVcWith(identifier: String ) -> LXFFindBaseController {
        let subFindType: LXFSubFindType = typeFromTitle(identifier)
        var controller: LXFFindBaseController!
        switch subFindType {
        case .LXFSubFindTypeRecommend:
            controller = LXFFindRecommendController()
        case .LXFSubFindTypeCategory:
            controller = LXFFindCategoryController()
        case .LXFSubFindTypeRadio:
            controller = LXFFindRadioController()
        case .LXFSubFindTypeRand:
            controller = LXFFindRandController()
        case .LXFSubFindTypeAnchor:
            controller = LXFFindAnchorController()
        default:
            controller = LXFFindBaseController()
        }
        return controller
    }
    
    // MARK:- 根据唯一标识符查找对应类型
    private class func typeFromTitle(_ title: String) -> LXFSubFindType {
        if title == "推荐" {
            return .LXFSubFindTypeRecommend
        } else if title == "分类" {
            return .LXFSubFindTypeCategory
        } else if title == "广播" {
            return .LXFSubFindTypeRadio
        } else if title == "榜单" {
            return .LXFSubFindTypeRand
        } else if title == "主播" {
            return .LXFSubFindTypeAnchor
        } else {
            return .LXFSubFindTypeUnkown
        }
    }
}

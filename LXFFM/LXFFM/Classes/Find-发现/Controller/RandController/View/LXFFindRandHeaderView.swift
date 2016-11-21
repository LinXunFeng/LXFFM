//
//  LXFFindRandHeaderView.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SDCycleScrollView

class LXFFindRandHeaderView: UIView {

    // MARK:- 定义属性
    /// 轮播图model
    var focusImgsPics: [String]!{
        didSet {
            setCycleView()
        }
    }
}

// MARK:- 设置轮播图
extension LXFFindRandHeaderView {
    func setCycleView() {
        // 移除所有子视图
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
        
        // 添加轮播视图
        if let cycleView = SDCycleScrollView(frame: self.frame, delegate: self, placeholderImage: nil) {
            cycleView.showPageControl = false
            cycleView.imageURLStringsGroup = focusImgsPics
            self.addSubview(cycleView)
        }
    }
}

// MARK:- SDCycleScrollViewDelegate
extension LXFFindRandHeaderView: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        LXFLog("点击了第\(index+1)张图")
    }
}

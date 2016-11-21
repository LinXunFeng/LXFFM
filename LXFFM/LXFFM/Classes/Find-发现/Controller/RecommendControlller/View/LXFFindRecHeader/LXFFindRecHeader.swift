//
//  LXFFindRecHeader.swift
//  LXFFM
//
//  Created by LXF on 2016/11/14.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SDCycleScrollView

let cycleViewH: CGFloat = 150   // 播视图高度
let cateIconW: Double = 71
let cateIconH: Double = 90

class LXFFindRecHeader: UIView {
    // MARK:- 连线属性
    /// 上方的广告轮播图
    @IBOutlet weak var adverScrollView: UIView!
    /// 下方的类别轮播图
    @IBOutlet weak var cateScorllView: UIScrollView!
    
    // MARK:- 定义属性
    /// 轮播图model
    var focusImgsPics: [String]! {
        didSet{
            setupCycleView()
        }
    }
    /// 分类 数组
    var categoryModelArr: [LXFFindDiscoveryColumnsList]! {
        didSet{
            setupCategorys()
        }
    }
    
    // MARK:- 创建视图
    class func newInstance() -> LXFFindRecHeader? {
        let nibView = Bundle.main.loadNibNamed("LXFFindRecHeader", owner: nil, options: nil)
        if let view = nibView?.first as? LXFFindRecHeader {
            return view
        }
        return nil
    }
}

// MARK:- viewModel被设置后调用
extension LXFFindRecHeader {
    // MARK: 设置轮播图
    func setupCycleView() {
        // 移除所有子视图
        _ = adverScrollView.subviews.map {
            $0.removeFromSuperview()
        }
        
        // 添加轮播视图
        if let cycleView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: cycleViewH), delegate: self, placeholderImage: nil) {
            cycleView.showPageControl = false
            cycleView.imageURLStringsGroup = focusImgsPics
            adverScrollView.addSubview(cycleView)
        }
    }
    
    // MARK: 设置分类
    func setupCategorys() {
        // 移除所有子视图
        _ = cateScorllView.subviews.map {
            $0.removeFromSuperview()
        }
        
        let headerCategorysCount: Double  = Double(categoryModelArr.count)
        if headerCategorysCount == 0 {
            return
        }
        
        // 添加分类按钮
        cateScorllView.contentSize = CGSize(width: cateIconW * headerCategorysCount, height: cateIconH)
        for index in 0..<categoryModelArr.count {
            let detailModel = categoryModelArr[index]
            if let iconView = LXFFindHeaderIconView.newInstance() {
                iconView.frame = CGRect(x: Double(index) * cateIconW, y: 0, width: cateIconW, height: cateIconH)
                iconView.model = detailModel
                cateScorllView.addSubview(iconView)
            }
        }
    }
}

// MARK:- SDCycleScrollViewDelegate
extension LXFFindRecHeader: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        LXFLog("点击了第\(index+1)张图")
    }
}

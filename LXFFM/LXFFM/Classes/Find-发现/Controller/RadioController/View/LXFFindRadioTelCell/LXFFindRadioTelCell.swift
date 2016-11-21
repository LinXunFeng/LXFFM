//
//  LXFFindRadioTelCell.swift
//  LXFFM
//
//  Created by LXF on 2016/11/20.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

fileprivate let telViewHeight: CGFloat = 100.0

class LXFFindTelView: UIView {
    // MARK:- 定义属性
    lazy var iconArr: [String] = {
        return ["icon_radio_local", "icon_radio_country", "icon_radio_province", "icon_radio_internet"]
    }()
    lazy var titleArr: [String] = {
        return ["本地台", "国家台", "省市台", "网络台"]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LXFFindTelView {
    func configSubViews() {
        let width: CGFloat = kScreenW / 4.0
        for i in 0..<iconArr.count {
            if let view = LXFFindHeaderIconView.newInstance() {
                view.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: self.frame.size.height)
                view.configWith(title: titleArr[i], localImgName: iconArr[i])
                self.addSubview(view)
            }
        }
    }
}

/* ============================================================ */

class LXFFindRadioTelCell: UITableViewCell {
    // MARK:- 定义属性
    var viewModel: LXFFindRadioViewModel? { didSet { setViewModel() } }
    // MARK:- 懒加载属性
    lazy var telView: LXFFindTelView = {
        let tel = LXFFindTelView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: telViewHeight))
        self.addSubview(tel)
        return tel
    }()
    
    // MARK:- 回调
//    typealias swapBlock = (_ cell: LXFFindRadioTelCell) -> Void
//    var showMoreOrHiddenBlock = swapBlock?()
    
    var showMoreOrHiddenBlock : ((_ cell: LXFFindRadioTelCell)->())?
    
}

// MARK:- didSet
extension LXFFindRadioTelCell {
    func setViewModel() {
        if viewModel == nil || viewModel?.categories.count == 0 {
            return
        }
        let isHidden = viewModel!.style == LXFFindRadioTelCellStyle.LXFFindRadioTelCellStyleHidden
        let max: NSInteger = isHidden ? 8 : 16
        
        // 移除所有按钮
        removeAllResufulBtn()
        
        let width: CGFloat = (kScreenW - 24.5) / 4.0
        for i in 0..<max {
            let col: NSInteger = i % 4 // 列
            let row: NSInteger = i / 4 // 行
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 10.0 + (width + 1.5) * CGFloat(col), y: CGFloat(row) * 46.0 + telViewHeight, width: width, height: 45.0)
            btn.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
            if i == max - 1 {
                let imgName = isHidden ? "icon_radio_show" : "icon_radio_hide"
                btn.setImage(UIImage(named: imgName), for: .normal)
                btn.addTarget(self, action: #selector(showMoreOrHiddenBtnClick(_:)), for: .touchUpInside)
            } else {
                if i >= viewModel!.categories.count { break }
                let item = viewModel?.categories[i]
                btn.setTitle(item?.name, for: .normal)
                btn.setTitleColor(UIColor.init(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.0), for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
            addSubview(btn)
        }
        // 添加telView
        telView.layoutSubviews()
    }
    
    /// 显示或隐藏电台
    @objc fileprivate func showMoreOrHiddenBtnClick(_ btn: UIButton) {
        showMoreOrHiddenBlock?(self)
    }
    
    /// 移除所有按钮
    fileprivate func removeAllResufulBtn() {
        _ = subviews.map {
            if $0.classForCoder == UIButton.classForCoder() {
                $0.removeFromSuperview()
            }
        }
    }
}

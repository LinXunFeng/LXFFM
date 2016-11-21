//
//  LXFSubScribeNavView.swift
//  LXFFM
//
//  Created by LXF on 2016/11/17.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

// MARK:- 定义颜色
fileprivate let kTitleColorNormal = UIColor (red: 0.40, green: 0.40, blue: 0.41, alpha: 1.0)
fileprivate let kTitleColorSelect = UIColor (red: 0.86, green: 0.39, blue: 0.30, alpha: 1.0)

class LXFSubScribeNavView: UIView {
    
    // MARK:- 回调属性
    var subScribeNavViewDidSubClick: ((_ view: LXFSubScribeNavView, _ index: NSInteger) -> ())?
    
    // MARK:- 懒加载属性
    /// 小滑块
    lazy var sliderView: UIView = { [unowned self] in
        let width = kScreenW / CGFloat(self.titles.count)
        let view = UIView()
        view.frame = CGRect(x: 2, y: self.height - 2.0, width: width - 4, height: 2)
        view.backgroundColor = kTitleColorSelect
        self.addSubview(view)
        return view
    }()

    // MARK:- 定义属性
    /// 标题数组
    var titles: [String] = [String]() {
        didSet{
            // 配置子视图
            configSubView()
        }
    }
}

// MARK:- 创建方法
extension LXFSubScribeNavView {
    class func createWith(titles: [String]) -> LXFSubScribeNavView {
        let view = LXFSubScribeNavView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 44))
        view.titles = titles
        return view
    }
}

// MARK:- 配置子视图
extension LXFSubScribeNavView {
    fileprivate func configSubView() {
        if titles.count == 0 { return }
        
        let width = kScreenW / CGFloat(titles.count)
        for index in 0..<titles.count {
            let title = titles[index]
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: 44)
            btn.setTitleColor(kTitleColorNormal, for: .normal)
            btn.setTitleColor(kTitleColorSelect, for: .selected)
            btn.setTitleColor(kTitleColorSelect, for: [.highlighted, .selected])
            btn.setTitle(title, for: .normal)
            if index == 0 { btn.isSelected = true }
            btn.addTarget(self, action: #selector(subBtnSelected(_ :)), for: .touchUpInside)
            btn.tag = 100 + index
            self.addSubview(btn)
        }
        // 初始化小滑块
        sliderView.layoutSubviews()
    }
}

// MARK:- 事件监听
extension LXFSubScribeNavView {
    // MARK: 点击事件处理
    @objc func subBtnSelected(_ btn: UIButton) {
        btn.isSelected = true
        unSelectedAllBtn(except: btn)
        slideViewAnimation(with: btn)
        // 回调闭包
        if (subScribeNavViewDidSubClick != nil) {
            subScribeNavViewDidSubClick!(self, btn.tag - 100)
        }
    }
    
    // MARK: 取消其它按键的选中状态
    fileprivate func unSelectedAllBtn(except btn: UIButton) {
        for view in subviews {
            if view.classForCoder == UIButton.classForCoder() && btn != view {
                (view as! UIButton).isSelected = false
            }
        }
    }
    // MARK: 小滑块的动画
    fileprivate func slideViewAnimation(with btn: UIButton) {
        UIView.animate(withDuration: 0.25) { 
            var frame = self.sliderView.frame
            frame.origin.x = btn.frame.origin.x + 2
            self.sliderView.frame = frame
        }
    }
}

// MARK:- 对外提供方法
extension LXFSubScribeNavView {
    // MARK: 设置当前滑块的位置
    func scrollToController(at index: NSInteger) {
        let btn = self.viewWithTag(index + 100) as! UIButton
        btn.isSelected = true
        unSelectedAllBtn(except: btn)
        slideViewAnimation(with: btn)
    }
}

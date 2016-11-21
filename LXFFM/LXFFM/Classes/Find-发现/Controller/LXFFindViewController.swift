//
//  LXFFindViewController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

// MARK:- 全局变量 - 当前navigationController
var findNaviController: UINavigationController?

class LXFFindViewController: LXFBaseController {
    
    // MARK:- 懒加载属性
    /// 子标题
    lazy var subTitleArr:[String] = {
        return ["推荐", "分类", "广播", "榜单", "主播"]
    }()
    
    /// 子控制器
    lazy var controllers: [UIViewController] = { [unowned self] in
        var cons: [UIViewController] = [UIViewController]()
        for title in self.subTitleArr {
            let con = LXFSubFindFactory.subFindVcWith(identifier: title)
            cons.append(con)
        }
        return cons
    }()
    
    /// 子标题视图
    lazy var subTitleView: LXFFindSubTitleView = { [unowned self] in
        let view = LXFFindSubTitleView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 40))
        self.view.addSubview(view)
        return view
    }()
    
    /// 控制多个子控制器
    lazy var lxfPageVc: LXFPageViewController = {
        let pageVc = LXFPageViewController(superController: self, controllers: self.controllers)
        pageVc.delegate = self
        self.view.addSubview(pageVc.view)
        return pageVc
    }()

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        view.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.0)
        title = "发现"
        
        subTitleView.delegate = self
        subTitleView.titleArray = subTitleArr
        // 配置子标题视图
        configSubViews()
        
        findNaviController = navigationController
    }
}

// MARK:- LXFPageViewController代理
extension LXFFindViewController: LXFPageViewControllerDelegate {
    func lxfPageCurrentSubControllerIndex(index: NSInteger, pageViewController: LXFPageViewController) {
        subTitleView.jump2Show(at: index)
    }
}

// MARK:- 配置子标题视图
extension LXFFindViewController {
    func configSubViews() {
        lxfPageVc.view.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-49)
        }
    }
}

// MARK:- LXFFindSubTitleViewDelegate
extension LXFFindViewController: LXFFindSubTitleViewDelegate {
    func findSubTitleViewDidSelected(_ titleView: LXFFindSubTitleView, atIndex: NSInteger, title: String) {
        // 跳转对相应的子标题界面
        lxfPageVc.setCurrentSubControllerWith(index: atIndex)
    }
}



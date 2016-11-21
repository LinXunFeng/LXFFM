//
//  LXFSubScribeViewController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

// MARK:- 视图类型枚举
enum LXFSubScribeStyle: NSInteger {
    case LXFSubScribeStyleScribe = 0    // 订阅听
    case LXFSubScribeStyleDownload = 1 // 下载听
}

class LXFSubScribeViewController: LXFBaseController {
    
    // MARK:- 定义属性
    var type: LXFSubScribeStyle = .LXFSubScribeStyleScribe
    
    // MARK:- 懒加载属性
    /// 选项导航栏
    lazy var nav: LXFSubScribeNavView = { [unowned self] in
        let titleArr: [String] = self.type == .LXFSubScribeStyleScribe ? ["推荐", "订阅", "历史"] : ["专辑", "声音", "下载中"]
        let navi = LXFSubScribeNavView.createWith(titles: titleArr)
        navi.subScribeNavViewDidSubClick = { [unowned self] (view, index) -> () in
            self.navigationDidSelectedController(with: index)
        }
        return navi
    }()
    
    /// 子控制器数组
    lazy var controllers: [UIViewController] = { [unowned self] in
        var cons: [UIViewController] = [UIViewController]()
        switch self.type {
        case .LXFSubScribeStyleScribe:
            cons.append(LXFScribeRecommendController())
            cons.append(LXFScribeMeScrController())
            cons.append(LXFScribeHistoryController())
        case .LXFSubScribeStyleDownload:
            cons.append(LXFDownAlbumController())
            cons.append(LXFDownVoiceController())
            cons.append(LXFDownLoadingController())
        }
        return cons
    }()
    
    /// 控制多个控制器的LXFPageViewController
    lazy var lxfPage: LXFPageViewController = { [unowned self] in
        let pageVc = LXFPageViewController(superController: self, controllers: self.controllers)
        pageVc.delegate = self
        self.view.addSubview(pageVc.view)
        return pageVc
    }()
    
    /* ============================================================ */
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK:- 重写init
    init(with type: LXFSubScribeStyle) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        
        // 配置子视图
        configSubViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.addSubview(self.nav)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navBarSubviews = navigationController?.navigationBar.subviews else { return }
        for view in navBarSubviews {
            if view.classForCoder == LXFSubScribeNavView.classForCoder() {
                view.removeFromSuperview()
            }
        }
    }
}


// MARK:- 配置子视图
extension LXFSubScribeViewController {
    func configSubViews() {
        lxfPage.view.snp.makeConstraints { [unowned self] (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
        }
    }
}

// MARK:- LXFPageViewControllerDelegate
extension LXFSubScribeViewController: LXFPageViewControllerDelegate {
    func lxfPageCurrentSubControllerIndex(index: NSInteger, pageViewController: LXFPageViewController) {
        // 改变小滑块的位置
        nav.scrollToController(at: index)
    }
}

// MARK:- nav上的按钮点击时在回调中调用的方法
extension LXFSubScribeViewController {
    fileprivate func navigationDidSelectedController(with index: NSInteger) {
        lxfPage.setCurrentSubControllerWith(index: index)
    }
}

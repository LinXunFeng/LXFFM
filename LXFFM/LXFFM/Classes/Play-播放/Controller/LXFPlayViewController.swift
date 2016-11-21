//
//  LXFPlayViewController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFPlayViewController: LXFBaseController {
    
    static let shareInstancd: LXFPlayViewController = {
        let playVc = LXFPlayViewController()
        return playVc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        configNavigationBar()
    }
}

extension LXFPlayViewController {
    func configNavigationBar() {
        // 左侧按钮
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        leftBtn.setImage(UIImage(named: "navidrop_arrow_down_h"), for: .normal)
        leftBtn.addTarget(self, action: #selector(backBtnClick(_ :)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        // 右侧按钮
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20)
        rightBtn.setImage(UIImage(named: "icon_share_h"), for: .normal)
        rightBtn.addTarget(self, action: #selector(shareBtnClick(_ :)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
}

// MARK:- 事件监听
extension LXFPlayViewController {
    // MARK: 导航栏左侧按钮
    @objc func backBtnClick(_ btn: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    // MARK: 导航栏右侧按钮
    @objc func shareBtnClick(_ btn: UIButton) {
        LXFLog("shareBtnClick:")
    }
}

//
//  MainViewController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/12.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

// tag的累积值
let kTagPlus: NSInteger = 100
// TabBar的高度
let kTabBarH: CGFloat = 49

class MainViewController: UITabBarController {
    
    // MARK:- 普通属性
    // 后方的背景生图片
    lazy var bgImageView: UIImageView = {
        let img   = UIImageView()
        img.frame = CGRect(x: 0, y: kScreenH - kTabBarH, width: kScreenW, height: kTabBarH)
        img.image = UIImage(named: "tabbar_bg")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    // MARK:- 懒加载
    // 按钮正常状态下的图片数组
    lazy var normalImageArray:[UIImage] = {
        var tempArray: [UIImage] = [UIImage]()
        tempArray.append(UIImage(named: "tabbar_find_n")!)
        tempArray.append(UIImage(named: "tabbar_sound_n")!)
        tempArray.append(UIImage(named: "tabbar_np_playnon")!)
        tempArray.append(UIImage(named: "tabbar_download_n")!)
        tempArray.append(UIImage(named: "tabbar_me_n")!)
        return tempArray
    }()
    
    // 按钮选中状态下的图片数组
    lazy var selectImageArray:[UIImage] = {
        var tempArray: [UIImage] = [UIImage]()
        tempArray.append(UIImage(named: "tabbar_find_h")!)
        tempArray.append(UIImage(named: "tabbar_sound_h")!)
        tempArray.append(UIImage(named: "tabbar_np_playnon")!)
        tempArray.append(UIImage(named: "tabbar_download_h")!)
        tempArray.append(UIImage(named: "tabbar_me_h")!)
        return tempArray
    }()

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自定义TabBar
        createCustomTabBar()
        // 配置子控制器
        configSubControllers()
    }
}

// MARK:- 初始化
extension MainViewController {
    // MARK: 自定义TabBar
    func createCustomTabBar() {
        // 隐藏原有TabBar
        tabBar.isHidden = true
        // 添加TabBar背景图
        view.addSubview(bgImageView)
        
        let width: CGFloat = kScreenW / 5.0
        for index in 0..<5 {
            let btn = UIButton(type: .custom)
            if index == 2 {
                btn.frame = CGRect(x: kScreenW * 0.5 - kTabBarH * 0.5, y: -10, width: kTabBarH + 10, height: kTabBarH + 10)
            } else {
                btn.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: kTabBarH)
            }
            btn.tag = kTagPlus + index
            btn.adjustsImageWhenHighlighted = false
            btn.setImage(normalImageArray[index], for: .normal)
            btn.setImage(selectImageArray[index], for: .selected)
            btn.addTarget(self, action: #selector(tabBarItemSelected(_ :)), for: .touchUpInside)
            
            bgImageView.addSubview(btn)
        }
        
        // 设置中间按钮阴影
        guard let playBtn = bgImageView.viewWithTag(102) else {return}
        let img = UIImageView(image: UIImage(named: "tabbar_np_shadow"))
        let btnW: CGFloat = playBtn.width + 6
        img.frame = CGRect(x: -3, y: -3, width: btnW, height: btnW * 13.0 / 15.0)
        playBtn.addSubview(img)
        
        // 设置默认选中第一个
        tabBarItemSelected(bgImageView.viewWithTag(kTagPlus) as! UIButton)
    }
    
    
    // MARK: 配置子控制器
    func configSubControllers() {
        tabBar.isHidden = true
        
        var tempArr: [LXFBaseNavigationController] = [LXFBaseNavigationController]()
        let findVc = navigationControllerWith(LXFFindViewController())
        tempArr.append(findVc)
        let subScribeVc = navigationControllerWith(LXFSubScribeViewController())
        tempArr.append(subScribeVc)
        let playVc = navigationControllerWith(LXFPlayViewController())
        tempArr.append(playVc)
        let downloadVc = navigationControllerWith(LXFDownloadViewController())
        tempArr.append(downloadVc)
        let mineVc = navigationControllerWith(LXFMineViewController())
        tempArr.append(mineVc)
        viewControllers = tempArr
        
    }
    func navigationControllerWith(_ vc: UIViewController) -> LXFBaseNavigationController {
        let nav = LXFBaseNavigationController(rootViewController: vc)
        nav.delegate = self
        return nav
    }
}

// MARK:- NavigationController代理
extension MainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            bgImageView.isHidden = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        tabBar.isHidden = true
        if !viewController.hidesBottomBarWhenPushed {
            bgImageView.isHidden = false
        }
    }
}

// MARK:- 事件监听
extension MainViewController {
    @objc func tabBarItemSelected(_ btn: UIButton) {
        btn.isSelected = true
        btn.isUserInteractionEnabled = false
        for sbtn in bgImageView.subviews {
            guard let xbtn = sbtn as? UIButton else {
                continue
            }
            if xbtn.tag == btn.tag {
                continue
            }
            xbtn.isSelected = false
            xbtn.isUserInteractionEnabled = true
        }
        let btnTag = btn.tag - kTagPlus         // 当前选中按钮的tag
        if versionTabBarSelectedIndex(btnTag) { // 非播放按钮
            selectedIndex  = btnTag
        } else {                                // 播放按钮
            btn.isSelected = false
            btn.isUserInteractionEnabled = true
        }
    }
    
    func versionTabBarSelectedIndex(_ index: NSInteger) -> Bool {
        if index == 2 { // 是播放界面
            // TODO: 差播放界面
            let playVc = LXFPlayViewController()
            let navi = LXFBaseNavigationController(rootViewController: playVc)
            present(navi, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}


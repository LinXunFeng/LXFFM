//
//  LXFMineHeaderView.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFMineHeaderView: UIView {
    
    // MARK:- 懒加载属性
    /// 背景视图
    lazy var backImageView: UIImageView = { [unowned self] in
        let img = UIImageView(image: UIImage(named: "find_radio_default"))
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        self.addSubview(img)
        return img
    }()
    
    /// 背景图上方的一层蒙版
    lazy var alphaView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.hexInt(0x000000)
        view.alpha = 0.3
        self.addSubview(view)
        return view
    }()
    
    /// 设置小按钮
    lazy var settingBtn: UIButton = { [unowned self] in
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "icon_setting"), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    /// 头像视图
    lazy var avatarImageView: UIImageView = { [unowned self] in
        let img = UIImageView(image: UIImage(named: "find_radio_default"))
        img.layer.cornerRadius = 45.0
        img.layer.masksToBounds = true
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 2.0
        // shouldRasterize = true 会使视图渲染内容被缓存起来，下次绘制的时候可以直接显示缓存，当然要在视图内容不改变的情况下
        img.layer.rasterizationScale = UIScreen.main.scale
        img.layer.shouldRasterize = true
        self.addSubview(img)
        return img
    }()
    
    /// 用户名按钮
    lazy var userNameBtn: UIButton = { [unowned self] in
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("点击登录", for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    /// 子标题
    lazy var subTitleLabel: UILabel = { [unowned self] in
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .center
        lab.text = "1秒登录, 专享个性化服务"
        self.addSubview(lab)
        return lab
    }()
    
    /// 节目管理按钮
    lazy var managerBtn: UIButton = { [unowned self] in
        let btn = UIButton(type: .custom)
        btn.setTitle("节目管理", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(RGBA(r: 0.36, g: 0.36, b: 0.36, a: 1.0), for: .normal)
        btn.setImage(UIImage(named: "ic_jmgl"), for: .normal)
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        self.addSubview(btn)
        return btn
    }()
    
    /// 录音按钮
    lazy var recordBtn: UIButton = { [unowned self] in
        let btn = UIButton(type: .custom)
        btn.setTitle("录音", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setImage(UIImage(named: "ic_rec_w"), for: .normal)
        btn.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        self.addSubview(btn)
        return btn
    }()
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 10.0
        let hspace: CGFloat = (self.width - kScreenW) * 0.5
        
        // 背景视图
        backImageView.frame = CGRect(x: hspace, y: 0, width: kScreenW, height: self.height)
        alphaView.frame = backImageView.frame
        
        // 节目管理
        let MRBtnW: CGFloat = 104.0
        let MRBtnH: CGFloat = 37.0
        managerBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-margin)
            make.bottom.equalTo(self.snp.bottom).offset(-36.0)
            make.width.equalTo(MRBtnW)
            make.height.equalTo(MRBtnH)
        }
        
        // 录音
        recordBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(margin)
            make.bottom.equalTo(managerBtn.snp.bottom)
            make.width.equalTo(MRBtnW)
            make.height.equalTo(MRBtnH)
        }
        
        // 子标题
        let subTitleLH: CGFloat = 15.0
        subTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.left.right.equalTo(self)
            make.bottom.equalTo(recordBtn.snp.top).offset(-24.0)
            make.height.equalTo(subTitleLH)
        }
        
        // 点击登录按钮
        let userNameBtnH: CGFloat = 18.0
        userNameBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.left.right.equalTo(self)
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-margin)
            make.height.equalTo(userNameBtnH)
        }
        
        // 头像
        let avatarWH: CGFloat = 90.0
        avatarImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(avatarWH)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(userNameBtn.snp.top).offset(-margin)
        }
        
        // 设置按钮
        let settingBtnWH: CGFloat = 20
        settingBtn.snp.makeConstraints { (make) in
            make.left.equalTo(hspace + 12)
            make.top.equalTo(backImageView.snp.top).offset(2 * margin)
            make.width.height.equalTo(settingBtnWH)
        }
    }

}














//
//  LXFFindHeaderIconView.swift
//  LXFFM
//
//  Created by LXF on 2016/11/14.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFFindHeaderIconView: UIView {

    // MARK:- 连线属性
    /// icon
    @IBOutlet weak var iconImgView: UIImageView!
    /// 标题
    @IBOutlet weak var titleL: UILabel!
    
    // MARK:- 自定属性
    // TODO: 这里是不对的,有待修改
    var model: LXFFindDiscoveryColumnsList! {
        didSet{
//            LXFLog(model)
            setupDetailModel()
        }
    }
    
    // MARK:- 创建视图
    class func newInstance() -> LXFFindHeaderIconView? {
        let nibView = Bundle.main.loadNibNamed("LXFFindHeaderIconView", owner: nil, options: nil)
        if let view = nibView?.first as? LXFFindHeaderIconView {
            return view
        }
        return nil
        
    }
}

// MARK:- viewModel被设置后调用
extension LXFFindHeaderIconView {
    func setupDetailModel() {
        guard let title = model.title else { return }
        titleL.text = title
        guard let imgUrl = model.coverPath else { return }
        iconImgView.sd_setImage(with: NSURL(string: imgUrl) as? URL)
    }
}

// MARK:- 为了复用提供的额外方法
extension LXFFindHeaderIconView {
    func configWith(title: String, localImgName: String) {
        titleL.text = title
        iconImgView.image = UIImage(named: localImgName)
    }
}

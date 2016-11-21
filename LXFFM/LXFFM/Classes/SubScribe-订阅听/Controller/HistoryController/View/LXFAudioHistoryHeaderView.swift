//
//  LXFAudioHistoryHeaderView.swift
//  LXFFM
//
//  Created by LXF on 2016/11/17.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFAudioHistoryHeaderView: UIView {
    
    // MARK:- 懒加载属性
    /// 选择删除
    lazy var selectDelete: UIButton = { [unowned self] in
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_select_listened_n"), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    /// 一键清空
    lazy var allDelete: UIButton = { [unowned self] in
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "btn_downloadsound_clear_n"), for: .normal)
        self.addSubview(btn)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = self.width / 2.0
        
        selectDelete.frame = CGRect(x: 0, y: 0, width: width, height: self.height)
        allDelete.frame = CGRect(x: width, y: 0, width: width, height: self.height)
    }
}

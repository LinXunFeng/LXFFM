//
//  LXFAnchorHeaderView.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFAnchorHeaderView: UICollectionReusableView {
    // MARK:- 连线属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
}

extension LXFAnchorHeaderView {
    func setModel(model: LXFAnchorSectionModel?) {
        titleL.text = model?.title ?? ""
    }
    
    func configHeader(title: String, showMore: Bool) {
        titleL.text = title
        moreBtn.isHidden = !showMore
    }
}

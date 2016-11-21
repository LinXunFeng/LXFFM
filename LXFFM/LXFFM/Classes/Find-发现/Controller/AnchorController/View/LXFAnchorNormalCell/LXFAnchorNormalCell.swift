//
//  LXFAnchorNormalCell.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFAnchorNormalCell: UICollectionViewCell {
    
    // MARK:- model
    var model: LXFAnchorSectionList? { didSet { setModel() } }

    // MARK:- 连线属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var describeL: UILabel!
    @IBOutlet weak var coverImgView: UIImageView!
    
    // MARK:- 生命周期
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImgView.layer.borderWidth = 0.5
        coverImgView.layer.borderColor = UIColor.init(red: 0.94, green: 0.95, blue: 0.95, alpha: 1.0).cgColor
    }
}

// MARK:- model处理
extension LXFAnchorNormalCell {
    func setModel() {
        if model == nil { return }
        titleL.text = model?.nickname ?? ""
        describeL.text = model?.verifyTitle ?? ""
        coverImgView.sd_setImage(with: URL(string: model?.largeLogo ?? ""), placeholderImage: UIImage(named: "find_radio_default"))
    }
}

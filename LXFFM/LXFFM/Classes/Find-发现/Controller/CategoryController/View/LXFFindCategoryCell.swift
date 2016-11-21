//
//  LXFFindCategoryCell.swift
//  LXFFM
//
//  Created by LXF on 2016/11/19.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFFindCategoryCell: UITableViewCell {
    
    // MARK:- 连线属性
    @IBOutlet weak var leftImgView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightImgView: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    // MARK:- 定义属性
    var leftModel: LXFListItemModel? {
        didSet {
            setLeftModel()
        }
    }
    var rightModel: LXFListItemModel? {
        didSet {
            setRightModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK:- 设置数据
extension LXFFindCategoryCell {
    func setLeftModel() {
        if leftModel == nil { return }
        leftLabel.text = leftModel?.title
        if let imgPath = leftModel?.coverPath {
            leftImgView.sd_setImage(with: URL(string: imgPath))
        }
    }
    func setRightModel() {
        if leftModel == nil { return }
        rightLabel.text = rightModel?.title
        if let imgPath = rightModel?.coverPath {
            rightImgView.sd_setImage(with: URL(string: imgPath))
        }
    }
}

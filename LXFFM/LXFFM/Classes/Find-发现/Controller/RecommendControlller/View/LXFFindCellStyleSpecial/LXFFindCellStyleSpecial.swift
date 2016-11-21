//
//  LXFFindCellStyleSpecial.swift
//  LXFFM
//
//  Created by LXF on 2016/11/15.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

protocol LXFFindCellStyleSpecialDelegate: NSObjectProtocol {
    func lxfFindCellStyleSpecialOn(cell: LXFFindCellStyleSpecial)
}

class LXFFindCellStyleSpecial: UITableViewCell {
    
    // MARK:- 代理
    weak var delegate: LXFFindCellStyleSpecialDelegate?
    
    // MARK:- 连续属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var iconUpImg: UIImageView!
    @IBOutlet weak var titleUpL: UILabel!
    @IBOutlet weak var subTitleUpL: UILabel!
    @IBOutlet weak var introUpL: UILabel!
    @IBOutlet weak var iconDownImg: UIImageView!
    @IBOutlet weak var titleDownL: UILabel!
    @IBOutlet weak var subTitleDownL: UILabel!
    @IBOutlet weak var introDownL: UILabel!
    
    // MARK:- 模型属性
    var special: LXFFindSpecialColumn? {
        didSet{
            setupSpecial()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

// MARK:- 模型方法
extension LXFFindCellStyleSpecial {
    func setupSpecial() {
        titleL.text = special?.title
        guard let specialList = special?.list else { return }
        for index in 0..<specialList.count {
            let model = specialList[index]
            let picUrl = URL(string: model.coverPath ?? "")
            switch index {
            case 0:
                iconUpImg.sd_setImage(with: picUrl)
                titleUpL.text = model.title
                subTitleUpL.text = model.subtitle
                introUpL.text = model.footnote
            case 1:
                iconDownImg.sd_setImage(with: picUrl)
                titleDownL.text = model.title
                subTitleDownL.text = model.subtitle
                introDownL.text = model.footnote
            default: break
            }
        }
    }
}

// MARK:- 事件监听
extension LXFFindCellStyleSpecial {
    // MARK: 更多
    @IBAction func moreBtnClick(_ sender: UIButton) {
        delegate?.lxfFindCellStyleSpecialOn(cell: self)
    }
}


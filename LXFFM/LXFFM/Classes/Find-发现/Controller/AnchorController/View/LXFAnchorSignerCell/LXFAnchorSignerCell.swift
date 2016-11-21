//
//  LXFAnchorSignerCell.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFAnchorSignerCell: UICollectionViewCell {
    
    // MARK:- model
    var model: LXFAnchorSectionList? { didSet { setModel() } }
    
    // MARK:- 连线属性
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var introlL: UILabel!
    @IBOutlet weak var albumNumL: UILabel!
    @IBOutlet weak var fansNumL: UILabel!
    @IBOutlet weak var attentionL: UIButton!
    @IBOutlet weak var userNameWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImgView.layer.cornerRadius = 25.0
        iconImgView.layer.masksToBounds = true
        //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
        iconImgView.layer.rasterizationScale = UIScreen.main.scale
        iconImgView.layer.shouldRasterize = true
    }
}


extension LXFAnchorSignerCell {
    func setModel() {
        if model == nil { return }
        
        let nickName = model!.nickname ?? ""
        let intro = model!.verifyTitle ?? ""
        let iconUrl = URL(string: model!.largeLogo ?? "")
        
        titleL.text = nickName
        introlL.text = intro
        albumNumL.text = "\(model!.tracksCounts)"
        fansNumL.text = "\(model!.followersCounts)"
        iconImgView.sd_setImage(with: iconUrl, placeholderImage: UIImage(named: "find_radio_default"))
        
        
        let size = nickName.getSize(with: 16.0)
        userNameWidthConstraint.constant = size.width + 2
    }
}

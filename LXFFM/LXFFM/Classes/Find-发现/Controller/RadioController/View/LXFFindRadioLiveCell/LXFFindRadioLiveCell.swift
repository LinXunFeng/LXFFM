//
//  LXFFindRadioLiveCell.swift
//  LXFFM
//
//  Created by LXF on 2016/11/20.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFFindRadioLiveCell: UITableViewCell {

    // MARK:- 连线属性
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var authorL: UILabel!
    @IBOutlet weak var usersL: UILabel!
    
    // MARK:- 定义属性
    var radioLive: LXFRadioLive? { didSet { setRadioLives() } }
}

// MARK:- 数据处理
extension LXFFindRadioLiveCell {
    func setRandDetailModel(detailModel: LXFFindRandList?) {
        if detailModel == nil {return}
        
        guard let result = detailModel?.firstKResults else { return }
        let title = result[0].title ?? ""
        let author = result[1].title ?? ""
        let users = result[2].title ?? ""
        
        titleL.text = title
        authorL.text = "1 \(author)"
        usersL.text = "2 \(users)"
        
        if let imgUrl = URL(string: (detailModel?.coverPath ?? "")) {
            coverImgView.sd_setImage(with: imgUrl)
        }
    }
    
    
    fileprivate func setRadioLives() {
        if radioLive == nil { return }
        titleL.text = radioLive?.name
        authorL.text = "直播中: \(radioLive!.programName!)"
        let countStr = getNumberAndText(with: (radioLive!.playCount))
        usersL.text = "收听人数: \(countStr)"
        if let imgUrl = URL(string: (radioLive?.coverLarge)!) {
            coverImgView.sd_setImage(with: imgUrl)
        }
    }
    
    fileprivate func getNumberAndText(with count: NSInteger) -> String {
        if count < 10000 {
            return String(format: "%ld", count)
        } else {
            return String(format: "%.1f万人", CGFloat(count) / 10000.0)
        }
    }
}

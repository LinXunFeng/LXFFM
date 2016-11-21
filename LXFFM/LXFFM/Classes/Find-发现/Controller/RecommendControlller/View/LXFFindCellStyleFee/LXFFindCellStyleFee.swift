//
//  LXFFindCellStyleFee.swift
//  LXFFM
//
//  Created by LXF on 2016/11/15.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

protocol LXFFindCellStyleFeeDelegate: NSObjectProtocol {
    func lxfFindCellStyleFeeMoreClickOn(cell: LXFFindCellStyleFee)
}


class LXFFindCellStyleFee: UITableViewCell {
    
    // MARK:- 代理
    weak var delegate: LXFFindCellStyleFeeDelegate?
    
    // MARK:- 连线属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var iconImgLeft: UIImageView!
    @IBOutlet weak var contentLeft: UILabel!
    @IBOutlet weak var subContentLeft: UILabel!
    @IBOutlet weak var iconImgMiddle: UIImageView!
    @IBOutlet weak var contentMiddle: UILabel!
    @IBOutlet weak var subContentMiddle: UILabel!
    @IBOutlet weak var iconImgRight: UIImageView!
    @IBOutlet weak var contentRight: UILabel!
    @IBOutlet weak var subContentRight: UILabel!
    
    // MARK:- 模型属性
    /// 小编推荐模型
    var recommendModel: LXFFindEditorRecommendAlbum? {
        didSet {
            setRecommendModel()
        }
    }
    /// 城市模型
    var cityColumnModel: LXFFindCityColumn? {
        didSet{
            setCityColumnModel()
        }
    }
    /// 猜你喜欢模型
    var guessModel: LXFFindGuess? {
        didSet{
            setGuessModel()
        }
    }
    /// 热门推荐模型
    var hotRecommendsList: LXFFindHotRecommendsList? {
        didSet{
            setHotRecommendsList()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK:- 模型方法
extension LXFFindCellStyleFee {
    func setRecommendModel() {
        guard (recommendModel != nil) else { return }
        titleL.text = recommendModel?.title
        setSubDetailsWith(list: (recommendModel?.list)!)
    }
    
    func setCityColumnModel() {
        guard (cityColumnModel != nil) else { return }
        titleL.text = cityColumnModel?.title
        setSubDetailsWith(list: (cityColumnModel?.list)!)
    }
    
    func setGuessModel() {
        guard (guessModel != nil) else { return }
        titleL.text = guessModel?.title
        setSubDetailsWith(list: (guessModel?.list)!)
    }
    
    func setHotRecommendsList() {
        guard (hotRecommendsList != nil) else { return }
        titleL.text = hotRecommendsList?.title
        setSubDetailsWith(list: (hotRecommendsList?.list)!)
    }
    
    
    
    func setSubDetailsWith(list: [LXFFindFeeDetailModel]) {
        for index in 0..<list.count {
            let model = list[index]
            let picUrl = URL(string: model.coverLarge ?? "")
            switch index {
            case 0:
                iconImgLeft.sd_setImage(with: picUrl)
                contentLeft.text = model.intro
                subContentLeft.text = model.title
            case 1:
                iconImgMiddle.sd_setImage(with: picUrl)
                contentMiddle.text = model.intro
                subContentMiddle.text = model.title
            case 2:
                iconImgRight.sd_setImage(with: picUrl)
                contentRight.text = model.intro
                subContentRight.text = model.title
            default:
                return
            }
        }
    }
}


// MARK:- 事件监听
extension LXFFindCellStyleFee {
    // MARK: 更多
    @IBAction func moreBtnClick(_ sender: UIButton) {
//        LXFLog("更多")
        delegate?.lxfFindCellStyleFeeMoreClickOn(cell: self)
    }
}


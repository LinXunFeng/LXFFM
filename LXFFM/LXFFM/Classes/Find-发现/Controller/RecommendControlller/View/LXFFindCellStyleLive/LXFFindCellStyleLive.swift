//
//  LXFFindCellStyleLive.swift
//  LXFFM
//
//  Created by LXF on 2016/11/15.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SDCycleScrollView

protocol LXFFindCellStyleLiveDelegate: NSObjectProtocol {
    func lxfFindCellStyleLiveMoreClickOn(cell: LXFFindCellStyleLive)
}

class LXFFindCellStyleLive: UITableViewCell {
    
    // MARK:- 代理
    weak var delegate: LXFFindCellStyleLiveDelegate?
    
    // MARK:- 连线属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var peopleCountL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var subContentL: UILabel!
    
    // MARK:- 模型数据
    var liveList: Array<LXFFindLive?> = [] {
        didSet{
            setLiveList()
        }
    }
    
    // MARK:- 定义属性
    var urlPics: [String] = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleL.text = "现场直播"
    }
}

// MARK:- 模型方法
extension LXFFindCellStyleLive {
    func setLiveList() {
        // 移除所有子控件
        _ = scrollView.subviews.map {
            $0.removeFromSuperview()
        }
        // 清空网络图片地址数组
        urlPics.removeAll()
        
        // 取出所有轮播图片地址
        for item in liveList {
            urlPics.append(item?.coverPath ?? "")
        }
        
        guard let cycleView = SDCycleScrollView(frame: scrollView.bounds, delegate: self, placeholderImage: nil) else { return }
        cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleNone
        cycleView.imageURLStringsGroup = urlPics
        scrollView.addSubview(cycleView)
    }
}

extension LXFFindCellStyleLive: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        LXFLog("你选中了第\(index)张")
    }
}


// MARK:- 事件监听
extension LXFFindCellStyleLive {
    // MARK: 更多
    @IBAction func moreBtnClick(_ sender: UIButton) {
        delegate?.lxfFindCellStyleLiveMoreClickOn(cell: self)
    }
}

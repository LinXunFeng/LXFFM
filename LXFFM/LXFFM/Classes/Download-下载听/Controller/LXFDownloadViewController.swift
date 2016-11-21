//
//  LXFDownloadViewController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SDWebImage



class LXFDownloadViewController: LXFSubScribeViewController {
    
    // MARK:- 懒加载
    lazy var storageL: UILabel = { [unowned self] in
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.text = "懒加载"
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.backgroundColor = UIColor.init(red: 0.65, green: 0.63, blue: 0.60, alpha: 1.0)
        lab.textAlignment = .center
        self.view.addSubview(lab)
        return lab
    }()

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置背景颜色
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        
        // 配置子视图
        configSubViews()
    }
}


// MARK:- 初始化StorageL的值
extension LXFDownloadViewController {
    func setupStorageCostLabel() {
        // 当前总使用量
        let cost = totalCostForStorage()
        let free = SpaceSizeTools.shareInstance.LXFDiskSpaceFree()
        let freeStr = SpaceSizeTools.shareInstance.LXFDiskSpaceFreeString(size: free)
        let title = String(format: "已占用空间%.2fM,可用空间%@", cost, freeStr)
        storageL.text = title
    }
    
    /// 当前总使用量
    func totalCostForStorage() -> CGFloat {
        let sdSize: CGFloat = CGFloat(sizeForSDWebImage())
        return  sdSize / (1024.0 * 1024.0)
    }
    
    /// 获取SDWebImage的缓存大小
    func sizeForSDWebImage() -> Int {
        return Int(SDWebImageManager.shared().imageCache.getSize())
    }
}

// MARK:- 重写配置子视图方法
extension LXFDownloadViewController {
    override func configSubViews() {
        self.type = .LXFSubScribeStyleDownload
        setupStorageCostLabel()
        
        storageL.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.right.equalTo(self.view)
            make.height.equalTo(25.0)
        }
        
        lxfPage.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.storageL.snp.bottom)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
        }
    }
}

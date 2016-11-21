//
//  LXFFindCategoryViewModel.swift
//  LXFFM
//
//  Created by LXF on 2016/11/19.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LXFFindCategoryViewModel: NSObject {
    
    // MARK:- 网络请求Model属性
    // 分类
    var discoveryColumns: LXFFindDiscoveryColumns!
    // list
    var listArr: Array<LXFListItemModel?> = []
    // 轮播图
    var focusImgs: LXFFindFocusImages!
    
    // MARK:- 对数据处理的属性
    /// 轮播图URL数组
    var focusImgsPics: [String] = [String]()
    /// 分类
    var headerCategorys: [LXFFindDiscoveryColumnsList] = [LXFFindDiscoveryColumnsList]()
    
    // MARK:- 数据更新回调
    typealias AddBlock = ()->Void;
    var updateBlock = AddBlock?()
}

// MARK:- 加载数据
extension LXFFindCategoryViewModel {
    func refreshDataSource() {
        // 加载 类别中的分类和banner下方的按钮
        LXFCateAPI.requestCategory { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                
                // 分类
                let discoveryColumns = JSONDeserializer<LXFFindDiscoveryColumns>.deserializeFrom(json: json["discoveryColumns"].description)
                // list
                if let listArr = JSONDeserializer<LXFListItemModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.listArr = listArr
                }
                
                self.discoveryColumns = discoveryColumns
                
                /* =============================== 处理数据 ============================= */
                /// 分类
                if let discoveryColumnsList = discoveryColumns?.list {
                    self.headerCategorys = discoveryColumnsList
                }
                
                // 更新tableView数据
                self.updateBlock?()
            }
        }
        // 加载 RecommendAPI
        LXFFindAPI.requestRecommends { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                // 轮播图
                let focusImgs = JSONDeserializer<LXFFindFocusImages>.deserializeFrom(json: json["focusImages"].description)
                
                self.focusImgs = focusImgs
                
                /* =============================== 处理数据 ============================= */
                /// 遍历取出轮播图
                if let focusImgsList = focusImgs?.list {
                    for item in focusImgsList {
                        self.focusImgsPics.append(item.pic ?? "")
                    }
                }
                // 更新tableView数据
                self.updateBlock?()
            }
        }
    }
}

// MARK:- tableView数据
extension LXFFindCategoryViewModel {
    // MARK: 计算section
    func numberOfSection() -> NSInteger {
        let sec = self.listArr.count / 6
        let sub = self.listArr.count % 6
        return sub > 0 ? sec + 1 : sec
    }
    // MARK: 计算section中的row
    func numberOfRowsIn(section: NSInteger) -> NSInteger {
        let sec: NSInteger = self.listArr.count / 6
        if section < sec {
            return 3
        } else {
            return (self.listArr.count % 6) / 2
        }
    }
    
    // MARK: 获取每行的viewModel
    func itemModel(with indexPath: IndexPath, isLeft: Bool) -> LXFListItemModel? {
        /*
                        推算
         
            0	1
            2	3		2*row+0		2*row+1+0
            4	5
            
            6	7
            8	9		2*row+6		2*row+1+6
            10	11
            
            12	13
            14	15		2*row+12    2*row+1+12
            16	17
            
            index = indexPath.section * 6
            index += indexPath.row * 2
            index = isLeft ? index : index+1
        */
        
        var index = indexPath.section * 6
        index += indexPath.row * 2
        index = isLeft ? index + 1 : index + 2  // 第一个付费精品不要,所以加1
        if listArr.count <= index {
            return nil
        }
        return listArr[index]!
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func heightForHeaderIn(section: NSInteger) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 10
        }
    }
}

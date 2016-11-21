//
//  LXFFindRecViewModel.swift
//  LXFFM
//
//  Created by LXF on 2016/11/14.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LXFFindRecViewModel: NSObject {
    
    // MARK:- 网络请求Model属性
    // 小编推荐
    var editorRecAlbum: LXFFindEditorRecommendAlbum!
    // 轮播图
    var focusImgs: LXFFindFocusImages!
    // 精品听单
    var special: LXFFindSpecialColumn!
    // 分类
    var discoveryColumns: LXFFindDiscoveryColumns!
    // 猜你喜欢
    var guess: LXFFindGuess!
    // 听北京
    var cityColumn: LXFFindCityColumn!
    // 热门推荐
    var hotRecommends: LXFFindHotRecommends!
    // 现场直播
    var liveList: Array<LXFFindLive?> = []
    
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
extension LXFFindRecViewModel {
    func refreshDataSource() {
        // 加载 RecommendAPI
        LXFFindAPI.requestRecommends { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                
                // 小编推荐
                let editorRecAlbum = JSONDeserializer<LXFFindEditorRecommendAlbum>.deserializeFrom(json: json["editorRecommendAlbums"].description)
                // 轮播图
                let focusImgs = JSONDeserializer<LXFFindFocusImages>.deserializeFrom(json: json["focusImages"].description)
                // 精品听单
                let special = JSONDeserializer<LXFFindSpecialColumn>.deserializeFrom(json: json["specialColumn"].description)
                
                self.editorRecAlbum = editorRecAlbum
                self.focusImgs = focusImgs
                self.special = special
                
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
        
        // 加载 HotAndGuessAPI
        LXFFindAPI.requestHotAndGuess { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                
                // 分类
                let discoveryColumns = JSONDeserializer<LXFFindDiscoveryColumns>.deserializeFrom(json: json["discoveryColumns"].description)
                // 猜你喜欢
                let guess = JSONDeserializer<LXFFindGuess>.deserializeFrom(json: json["guess"].description)
                // 听北京
                let cityColumn = JSONDeserializer<LXFFindCityColumn>.deserializeFrom(json: json["cityColumn"].description)
                // 热门推荐
                let hotRecommends = JSONDeserializer<LXFFindHotRecommends>.deserializeFrom(json: json["hotRecommends"].description)
                
                
                self.discoveryColumns = discoveryColumns
                self.guess = guess
                self.cityColumn = cityColumn
                self.hotRecommends = hotRecommends
                
                /* =============================== 处理数据 ============================= */
                /// 分类
                if let discoveryColumnsList = discoveryColumns?.list {
                    self.headerCategorys = discoveryColumnsList
                }
                
                // 更新tableView数据
                self.updateBlock?()
            }
        }
        
        LXFFindAPI.requestLiveRecommend { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                // 现场直播
                if let liveArray = JSONDeserializer<LXFFindLive>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.liveList = liveArray
                }
                
                // 更新tableView数据
                self.updateBlock?()
            }
        }
    }
}


// MARK:- 各section的高度
let kSectionHeight: CGFloat        = 230.0
let kSectionLiveHeight: CGFloat    = 227.0
let kSectionSpecialHeight: CGFloat = 219.0
let kSectionMoreHeight: CGFloat    = 60.0

// MARK:- tableView的数据
extension LXFFindRecViewModel {
    func numberOfSections() -> NSInteger {
        return 8
    }
    func numberOfItemInSection(_ section: NSInteger) -> NSInteger {
        // 各值定义在 LXFFindRecommendController 下
        switch section {
        case kFindSectionEditCommen:    // 小编推荐
            return 1
        case kFindSectionLive:          // 现场直播
            return liveList.count == 0 ? 0 : 1
        case kFindSectionGuess:         // 猜你喜欢
            guard (guess != nil) else { return 0 }
            return guess.list?.count == 0 ? 0 : 1
        case kFindSectionCityColumn:    // 城市歌单
            guard (cityColumn != nil) else { return 0 }
            return cityColumn.list?.count == 0 ? 0 : 1
        case kFindSectionSpecial:       // 精品听单
            guard (special != nil) else { return 0 }
            return special.list?.count == 0 ? 0 : 1
        case kFindSectionAdvertise:     // 推广
            return 0    // 暂时未找到接口
        case kFindSectionHotCommends:   // 热门推荐
            guard (hotRecommends != nil) else { return 0 }
            return (hotRecommends.list?.count)!
        case kFindSectionMore:          // 更多分类
            return 1
        default:
            return 0
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kFindSectionEditCommen:    // 小编推荐
            return kSectionHeight
        case kFindSectionLive:          // 现场直播
            return liveList.count == 0 ? 0 : kSectionLiveHeight
        case kFindSectionGuess:         // 猜你喜欢
            guard (guess != nil) else { return 0 }
            return guess.list?.count == 0 ? 0 : kSectionHeight
        case kFindSectionCityColumn:    // 城市歌单
            guard (cityColumn != nil) else { return 0 }
            return cityColumn.list?.count == 0 ? 0 : kSectionHeight
        case kFindSectionSpecial:       // 精品听单
            guard (special != nil) else { return 0 }
            return special.list?.count == 0 ? 0 : kSectionSpecialHeight
        case kFindSectionAdvertise:     // 推广
            return 0    // 暂时未找到接口
        case kFindSectionHotCommends:   // 热门推荐
            return kSectionHeight
        case kFindSectionMore:          // 更多分类
            return kSectionMoreHeight
        default:
            return 0
        }
    }
}

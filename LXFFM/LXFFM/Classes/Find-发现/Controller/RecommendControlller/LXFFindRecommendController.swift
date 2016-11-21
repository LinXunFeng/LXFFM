//
//  LXFFindRecommendController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


// MARK:- 各个section
let kFindSectionEditCommen  = 0     // 小编推荐
let kFindSectionLive        = 1     // 现场直播
let kFindSectionGuess       = 2     // 猜你喜欢
let kFindSectionCityColumn  = 3     // 城市歌单
let kFindSectionSpecial     = 4     // 精品听单
let kFindSectionAdvertise   = 5     // 推广
let kFindSectionHotCommends = 6     // 热门推荐
let kFindSectionMore        = 7     // 更多分类

// MARK:- 注册tableView的cellID
fileprivate let LXFFindCellStyleFeeID     = "LXFFindCellStyleFee"
fileprivate let LXFFindCellStyleLiveID    = "LXFFindCellStyleLive"
fileprivate let LXFFindCellStyleSpecialID = "LXFFindCellStyleSpecial"
fileprivate let LXFFindCellStyleMoreID    = "LXFFindCellStyleMore"

class LXFFindRecommendController: LXFFindBaseController {
    
    // MARK:- 懒加载属性
    /// 头部
    let headerFrame: CGRect = CGRect(x: 0, y: 0, width: kScreenW, height: 250)
    lazy var header: LXFFindRecHeader = { [unowned self] in
        let recHeader = LXFFindRecHeader.newInstance()
        recHeader?.frame = self.headerFrame
        recHeader?.layoutIfNeeded()
        return recHeader!
    }()
    
    /// tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.tableHeaderView = UIView(frame: self.headerFrame)
        tab.tableHeaderView?.addSubview(self.header)
        self.view.addSubview(tab)
        // 注册cellID
        tab.register(UINib(nibName: LXFFindCellStyleFeeID, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleFeeID)
        tab.register(UINib(nibName: LXFFindCellStyleLiveID, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleLiveID)
        tab.register(UINib(nibName: LXFFindCellStyleSpecialID, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleSpecialID)
        tab.register(UINib(nibName: LXFFindCellStyleMoreID, bundle: nil), forCellReuseIdentifier: LXFFindCellStyleMoreID)
        return tab
    }()
    
    /// viewModel
    lazy var viewModel: LXFFindRecViewModel = {
        return LXFFindRecViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 视图背景颜色
        view.backgroundColor = UIColor.white
        
        // 加载数据
        viewModel.updateBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
            self.header.focusImgsPics = self.viewModel.focusImgsPics
            self.header.categoryModelArr = self.viewModel.headerCategorys
        }
        viewModel.refreshDataSource()
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFFindRecommendController: UITableViewDelegate, UITableViewDataSource {
    // MARK: 各section值
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    // MARK: 各section的row值
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection(section)
    }
    // MARK: cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {  // 小编推荐
        case kFindSectionEditCommen:
            let editCommenCell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleFeeID) as? LXFFindCellStyleFee
            editCommenCell?.recommendModel = viewModel.editorRecAlbum
            editCommenCell?.selectionStyle = .none
            editCommenCell?.delegate = self
            return editCommenCell!
        case kFindSectionLive:  // 现场直播
            if viewModel.liveList.count != 0 {
                let liveCell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleLiveID) as? LXFFindCellStyleLive
                liveCell?.selectionStyle = .none
                liveCell?.liveList = viewModel.liveList
                liveCell?.delegate = self
                return liveCell!
            }
            return UITableViewCell()
        case kFindSectionGuess: // 猜你喜欢
            guard (viewModel.guess != nil) else {
                return UITableViewCell()
            }
            if viewModel.guess.list?.count != 0 {
                let guessCell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleFeeID) as? LXFFindCellStyleFee
                guessCell?.selectionStyle = .none
                guessCell?.guessModel = viewModel.guess
                return guessCell!
            }
            return UITableViewCell()
        case kFindSectionCityColumn:    // 城市歌单
            guard viewModel.cityColumn != nil else {
                return UITableViewCell()
            }
            if viewModel.cityColumn.list?.count != 0 {
                let cityCell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleFeeID) as? LXFFindCellStyleFee
                cityCell?.selectionStyle = .none
                cityCell?.cityColumnModel = viewModel.cityColumn
                return cityCell!
            }
            return UITableViewCell()
        case kFindSectionSpecial:    // 精品听单
            guard viewModel.special != nil else {
                return UITableViewCell()
            }
            if viewModel.special.list?.count != 0 {
                let specialCell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleSpecialID) as? LXFFindCellStyleSpecial
                specialCell?.selectionStyle = .none
                specialCell?.special = viewModel.special
                specialCell?.delegate = self
                return specialCell!
            }
            return UITableViewCell()
        case kFindSectionAdvertise:    // 推广
            return UITableViewCell()    // 暂时未找到接口
        case kFindSectionHotCommends:    // 热门推荐
            let hotCommen = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleFeeID) as? LXFFindCellStyleFee
            hotCommen?.selectionStyle = .none
            if let hotRecList = viewModel.hotRecommends.list {
                hotCommen?.hotRecommendsList = hotRecList[indexPath.row]
            }
            return hotCommen!
        case kFindSectionMore:    // 更多分类
            let moreCell = tableView.dequeueReusableCell(withIdentifier: LXFFindCellStyleMoreID) as? LXFFindCellStyleMore
            moreCell?.selectionStyle = .none
            return moreCell!
        default:    // 其它
            return UITableViewCell()
        }
    }
    // MARK: cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }
}


// MARK:- cell的代理
// MARK: 更多 - 小编推荐
extension LXFFindRecommendController: LXFFindCellStyleFeeDelegate {
    func lxfFindCellStyleFeeMoreClickOn(cell: LXFFindCellStyleFee) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        switch indexPath.section {
        case kFindSectionEditCommen:
            // 跳转 - 小编推荐
            jump2EditRecController()
        default: break
        }
    }
}
// MARK: 更多 - 现场直播
extension LXFFindRecommendController: LXFFindCellStyleLiveDelegate {
    func lxfFindCellStyleLiveMoreClickOn(cell: LXFFindCellStyleLive) {
        LXFLog("LXFFindCellStyleLiveDelegate")
    }
}
// MARK: 更多 - 精品听单
extension LXFFindRecommendController: LXFFindCellStyleSpecialDelegate {
    func lxfFindCellStyleSpecialOn(cell: LXFFindCellStyleSpecial) {
        LXFLog("LXFFindCellStyleSpecialDelegate")
    }
}

// MARK:- 界面跳转
extension LXFFindRecommendController {
    // MARK: 跳转 - 小编推荐
    func jump2EditRecController() {
        let editRecVc = LXFEditRecommendController()
        editRecVc.hidesBottomBarWhenPushed = true
        findNaviController?.pushViewController(editRecVc, animated: true)
    }
}




















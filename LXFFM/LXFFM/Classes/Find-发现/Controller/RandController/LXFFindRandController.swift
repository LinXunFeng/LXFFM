//
//  LXFFindRandController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

// MARK:- 注册tableView的cellID
fileprivate let LXFFindRadioLiveCellID = "LXFFindRadioLiveCell"

class LXFFindRandController: LXFFindBaseController {
    
    // MARK:- 网络数据属性
    var focusImages: LXFFindFocusImages? { didSet { setFocusImgs() } }
    var datas: Array<LXFFindRandModel?> = [] { didSet { setDatas() } }
    
    // MARK:- 懒加载属性
    /// 头部
    let headerFrame: CGRect = CGRect(x: 0, y: 0, width: kScreenW, height: 150)
    lazy var headerView: LXFFindRandHeaderView = { [unowned self] in
        let header = LXFFindRandHeaderView()
        header.frame = self.headerFrame
        header.layoutIfNeeded()
        return header
    }()
    /// tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.tableHeaderView = UIView(frame: self.headerFrame)
        tab.tableHeaderView?.addSubview(self.headerView)
        self.view.addSubview(tab)
        // 注册cellID
        tab.register(UINib(nibName: LXFFindRadioLiveCellID, bundle: nil), forCellReuseIdentifier: LXFFindRadioLiveCellID)
        return tab
    }()

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        // 请求Rank排行榜数据
        requestRankDetails()
        
        
    }
}

// MARK:- 处理model
extension LXFFindRandController {
    func setFocusImgs() {
        if focusImages == nil { return }
        
        var imgArr: [String] = [String]()
        guard let imgList = focusImages?.list else { return }
        for img in imgList {
            imgArr.append(img.pic ?? "")
        }
        self.headerView.focusImgsPics = imgArr
        tableView.reloadData()
    }
    
    func setDatas() {
        tableView.reloadData()
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFFindRandController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = datas[section]
        return data?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = datas[indexPath.section]
        let detailModel = data?.list?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LXFFindRadioLiveCellID) as? LXFFindRadioLiveCell
        cell?.setRandDetailModel(detailModel: detailModel)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = datas[section]
        let view = LXFFindRadioSectionHeaderView(model: data, showMore: false)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}


// MARK:- 请求Rank排行榜数据
extension LXFFindRandController {
    func requestRankDetails() {
        LXFRankAPI.requestRank { [unowned self] (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                
                let focusImages = JSONDeserializer<LXFFindFocusImages>.deserializeFrom(json: json["focusImages"].description)
                
                self.focusImages = focusImages
                
                if let datas = JSONDeserializer<LXFFindRandModel>.deserializeModelArrayFrom(json: json["datas"].description) {
                    self.datas = datas
                }
            }
        }
    }
}



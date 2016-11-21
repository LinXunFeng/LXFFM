//
//  LXFFindRadioController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

let kSectionTel   = 0   // 电台section
let kSectionLocal = 1   // 本地section
let kSectionTop   = 2   // 排行榜section

// MARK:- 注册tableView的cellID
fileprivate let LXFFindRadioTelCellID  = "LXFFindRadioTelCell"
fileprivate let LXFFindRadioLiveCellID = "LXFFindRadioLiveCell"

class LXFFindRadioController: LXFFindBaseController {
    
    // MARK:- 懒加载属性
    /// tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        tab.separatorStyle = .none
        self.view.addSubview(tab)
        // 注册CellID
        tab.register(UINib(nibName: LXFFindRadioLiveCellID, bundle: nil), forCellReuseIdentifier: LXFFindRadioLiveCellID)
        return tab
    }()
    
    /// viewModel
    lazy var viewModel: LXFFindRadioViewModel = {
        return LXFFindRadioViewModel()
    }()

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        // 初始化
        setup()
    }
}

// MARK:- 初始化
extension LXFFindRadioController {
    func setup() {
        // 加载数据
        viewModel.updateBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

// MARK:- 显示或隐藏更多电台的方法
extension LXFFindRadioController {
    func userClickShowMoreOrHiddenBtn() {
        if viewModel.style == .LXFFindRadioTelCellStyleHidden {
            viewModel.style = .LXFFindRadioTelCellStyleShow
        } else {
            viewModel.style = .LXFFindRadioTelCellStyleHidden
        }
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFFindRadioController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == kSectionTel {   // 电台section
            var cell = tableView.dequeueReusableCell(withIdentifier: LXFFindRadioTelCellID) as? LXFFindRadioTelCell
            if cell == nil {
                cell = LXFFindRadioTelCell(style: .default, reuseIdentifier: LXFFindRadioTelCellID)
            }
            cell?.selectionStyle = .none
            cell?.viewModel = viewModel
            cell?.showMoreOrHiddenBlock = { [unowned self] _ in
                self.userClickShowMoreOrHiddenBtn()
            }
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: LXFFindRadioLiveCellID) as? LXFFindRadioLiveCell
        var model: LXFRadioLive?
        if indexPath.section == kSectionTop {   // 本地section
            model = viewModel.topRadios[indexPath.row]
        } else {    // 排行榜section
            model = viewModel.localRadios[indexPath.row]
        }
        cell?.radioLive = model
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == kSectionTel { return nil }
        let style = getSectionHeaderStyle(section: section)
        let view = LXFFindRadioSectionHeaderView(style: style, location: viewModel.location ?? "")
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 44)
        return view
    }
}

// MARK:- 通过section获取对应的headerView的style
extension LXFFindRadioController {
    func getSectionHeaderStyle(section: NSInteger) -> LXFRadioSectionHeaderViewStyle {
        switch section {
        case 1:  return .LXFRadioSectionHeaderViewStyleLocal
        case 2: return .LXFRadioSectionHeaderViewStyleTop
        default: return .LXFRadioSectionHeaderViewStyleHistory
        }
    }
}


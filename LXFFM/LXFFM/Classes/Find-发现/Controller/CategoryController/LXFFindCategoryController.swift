//
//  LXFFindCategoryController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

// MARK:- 注册tableView的cellID
fileprivate let LXFFindCategoryCellID = "LXFFindCategoryCell"

class LXFFindCategoryController: LXFFindBaseController {
    // MARK:- 懒加载属性
    /// 头部视图
    let headerFrame: CGRect = CGRect(x: 0, y: 0, width: kScreenW, height: 250)
    lazy var headerView: LXFFindRecHeader = { [unowned self] in
        let header = LXFFindRecHeader.newInstance()
        header?.frame = self.headerFrame
        header?.layoutIfNeeded()
        return header!
    }()
    /// tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        tab.tableHeaderView = UIView(frame: self.headerFrame)
        tab.tableHeaderView?.addSubview(self.headerView)
        tab.backgroundColor = UIColor.white
        tab.separatorStyle = .none
        self.view.addSubview(tab)
        // 注册CellID
        tab.register(UINib(nibName: LXFFindCategoryCellID, bundle: nil), forCellReuseIdentifier: LXFFindCategoryCellID)
        return tab
    }()
    /// viewModel
    lazy var viewModel: LXFFindCategoryViewModel = {
        return LXFFindCategoryViewModel()
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
extension LXFFindCategoryController {
    func setup() {
        // 加载数据
        viewModel.updateBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
            self.headerView.focusImgsPics = self.viewModel.focusImgsPics
            self.headerView.categoryModelArr = self.viewModel.headerCategorys
        }
        viewModel.refreshDataSource()
    }
}


// MARK:- UITableViewDataSource & UITableViewDelegate
extension LXFFindCategoryController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LXFFindCategoryCellID) as? LXFFindCategoryCell
        cell?.leftModel = viewModel.itemModel(with: indexPath, isLeft: true)
        cell?.rightModel = viewModel.itemModel(with: indexPath, isLeft: false)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10.0))
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}





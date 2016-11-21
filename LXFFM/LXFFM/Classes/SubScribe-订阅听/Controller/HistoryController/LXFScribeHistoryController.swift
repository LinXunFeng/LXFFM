//
//  LXFScribeHistoryController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/17.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LXFScribeHistoryController: LXFBaseController {

    // MARK:- 懒加载
    lazy var headerView: LXFAudioHistoryHeaderView = { [unowned self] in
        let header = LXFAudioHistoryHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 44))
        self.view.addSubview(header)
        return header
    }()
    
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView()
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        tab.tableFooterView = UIView()
        tab.tableHeaderView = self.headerView
        self.view.addSubview(tab)
        tab.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        // 设置空视图状态
        configEmptStatus()
    }
}

// MARK:- 初始化
extension LXFScribeHistoryController {
    // MARK: 设置空视图状态
    func configEmptStatus() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}


// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFScribeHistoryController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK:- DZNEmptyDataSetDelegate & DZNEmptyDataSetSource
extension LXFScribeHistoryController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "noData_play_history")
    }
    
}

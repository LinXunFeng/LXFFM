//
//  LXFScribeMeScrController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/17.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LXFScribeMeScrController: LXFBaseController {
    
    // MARK:- 懒加载
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView()
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        tab.tableFooterView = UIView()
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
extension LXFScribeMeScrController {
    // MARK: 设置空视图状态
    func configEmptStatus() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFScribeMeScrController: UITableViewDelegate, UITableViewDataSource {
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
extension LXFScribeMeScrController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "noData_subscription")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "登陆已有账号>>"
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.init(red: 0.84, green: 0.51, blue: 0.44, alpha: 1.0), NSParagraphStyleAttributeName: paragraph]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
}

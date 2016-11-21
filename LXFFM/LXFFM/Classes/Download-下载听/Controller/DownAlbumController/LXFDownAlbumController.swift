//
//  LXFDownAlbumController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/17.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LXFDownAlbumController: LXFBaseController {
    
    // MARK:- 定义属性
    var noDataImg: UIImage!
    
    // MARK:- 懒加载属性
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
        
        // 设置空视图图片
        noDataImg = UIImage(named: "noData_play_history")
        
        // 设置空视图状态
        configEmptStatus()
    }
}


// MARK:- 初始化
extension LXFDownAlbumController {
    // MARK: 设置空视图状态
    func configEmptStatus() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFDownAlbumController: UITableViewDelegate, UITableViewDataSource {
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
extension LXFDownAlbumController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return noDataImg
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "去看看"
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), NSParagraphStyleAttributeName: paragraph, NSBackgroundColorAttributeName: UIColor.white]
        return NSAttributedString(string: text, attributes: attributes)
    }
}



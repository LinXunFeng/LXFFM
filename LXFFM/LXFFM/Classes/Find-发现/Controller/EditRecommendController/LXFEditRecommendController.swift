//
//  LXFEditRecommendController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/16.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFEditRecommendController: UIViewController {
    
    // MARK:- 懒加载属性
    lazy var tableView: UITableView! = { [unowned self] in
        let tab = UITableView(frame: self.view.bounds, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        tab.separatorStyle = .none
        self.view.addSubview(tab)
        return tab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "小编推荐"
        view.backgroundColor = UIColor.red
        
        // TODO: 更多 界面还未完成
        LXFEditRecAPI.requestEditRecWith(page: 0) { (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                LXFLog(result)
            }
        }
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension LXFEditRecommendController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}

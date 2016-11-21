//
//  LXFDownLoadingController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/17.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFDownLoadingController: LXFDownAlbumController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置空视图图片
        noDataImg = UIImage(named: "noData_downloading")
    }

}


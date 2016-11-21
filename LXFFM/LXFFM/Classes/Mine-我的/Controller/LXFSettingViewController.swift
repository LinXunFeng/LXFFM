//
//  LXFSettingViewController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

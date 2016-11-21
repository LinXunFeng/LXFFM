//
//  LXFFindAnchorController.swift
//  LXFFM
//
//  Created by LXF on 2016/11/13.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

// MARK:- 注册所需CellID
fileprivate let kLXFAnchorNormalCellID = "LXFAnchorNormalCell"
fileprivate let kLXFAnchorSignerCellID = "LXFAnchorSignerCell"
fileprivate let kLXFAnchorHeaderViewID = "LXFAnchorHeaderView"
fileprivate let kLXFAnchorFooterViewID = "LXFAnchorFooterView"
// MARK:- 区别header/footer
fileprivate let kSectionHeader = "UICollectionElementKindSectionHeader"
fileprivate let kSectionFooter = "UICollectionElementKindSectionFooter"

class LXFFindAnchorController: LXFFindBaseController {
    
    // MARK:- 网络数据属性
    var dataSource:  Array<LXFAnchorSectionModel?> = [] { didSet { setDataSource() } }
    
    // MARK:- 懒加载属性
    /// collectionView
    lazy var collectionView: UICollectionView = { [unowned self] in
        let frame = self.view.frame
        let layout = LXFAnchorFlowLayout()
        let col = UICollectionView(frame: frame, collectionViewLayout: layout)
        // 注册cellID
        col.register(UINib(nibName: kLXFAnchorNormalCellID, bundle: nil), forCellWithReuseIdentifier: kLXFAnchorNormalCellID)
        col.register(UINib(nibName: kLXFAnchorSignerCellID, bundle: nil), forCellWithReuseIdentifier: kLXFAnchorSignerCellID)
        // 注册headerID
        col.register(UINib(nibName: kLXFAnchorHeaderViewID, bundle: nil), forSupplementaryViewOfKind: kSectionHeader, withReuseIdentifier: kLXFAnchorHeaderViewID)
        // 注册footerID
        col.register(UINib(nibName: kLXFAnchorFooterViewID, bundle: nil), forSupplementaryViewOfKind: kSectionFooter, withReuseIdentifier: kLXFAnchorFooterViewID)
        col.delegate = self
        col.dataSource = self
        col.backgroundColor = UIColor.hexInt(0xf0f0f0)
        self.view.addSubview(col)
        return col
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景颜色
        view.backgroundColor = UIColor.hexInt(0xf0f0f0)
        requestDataSource()
    }
}


// MARK:- 处理model
extension LXFFindAnchorController {
    func setDataSource() {
        collectionView.reloadData()
    }
}


extension LXFFindAnchorController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = dataSource[section]
        guard let list = model?.list else { return 0 }
        let count = list.count
        return count - count % 3    //保证每一行是3的倍数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.section]
        let modelDetail = model?.list?[indexPath.row]
        
        if model?.displayStyle == 2{    // 歌手
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kLXFAnchorSignerCellID, for: indexPath) as? LXFAnchorSignerCell
            cell?.model = modelDetail
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kLXFAnchorNormalCellID, for: indexPath) as? LXFAnchorNormalCell
            cell?.model = modelDetail
            return cell!
        }
    }
    
    //item size 210 x 320
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = dataSource[indexPath.section]
        if model?.displayStyle == 2 {   // 歌手
            return CGSize(width: kScreenW, height: 90)
        }
        
        let width = kScreenW / 3.0
        let height = 32.0 * width / 21.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // headerView
        if kind == kSectionHeader {
            let model = dataSource[indexPath.section]
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kSectionHeader, withReuseIdentifier: kLXFAnchorHeaderViewID, for: indexPath) as? LXFAnchorHeaderView
            header?.setModel(model: model)
            return header!
        } else {    // footerView
            return collectionView.dequeueReusableSupplementaryView(ofKind: kSectionFooter, withReuseIdentifier: kLXFAnchorFooterViewID, for: indexPath)
        }
    }
    
    //footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 10)
    }
    
    //header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


// MARK:- 请求数据
extension LXFFindAnchorController {
    func requestDataSource() {
        LXFAnchorAPI.requestAnchorData { (result, error) in
            if error != nil {
                LXFLog(error)
            } else {
                let json = JSON(result)
                
                if let famous = JSONDeserializer<LXFAnchorSectionModel>.deserializeModelArrayFrom(json: json["famous"].description) {
                    self.dataSource += famous
                }
                
                if let normal = JSONDeserializer<LXFAnchorSectionModel>.deserializeModelArrayFrom(json: json["normal"].description) {
                    self.dataSource += normal
                }
            }
        }
    }
}

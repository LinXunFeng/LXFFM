//
//  LXFAnchorFlowLayout.swift
//  LXFFM
//
//  Created by LXF on 2016/11/21.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class LXFAnchorFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        // 1.设置itemSize
        itemSize                = collectionView!.frame.size
        minimumLineSpacing      = 0             // 设置最小行间距
        minimumInteritemSpacing = 0             // 设置最小item间距
        scrollDirection         = .vertical     // 设置滚动方向
        
        // 2.设置collectionView的属性
        collectionView?.isPagingEnabled                = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator   = false
    }
}

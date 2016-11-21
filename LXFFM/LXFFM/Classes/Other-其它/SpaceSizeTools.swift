//
//  SpaceSizeTools.swift
//  LXFFM
//
//  Created by LXF on 2016/11/18.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

class SpaceSizeTools: NSObject {
    static let shareInstance: SpaceSizeTools = {
        let tools = SpaceSizeTools()
        return tools
    }()
}


// MARK:- 获取磁盘空闲空间大小
extension SpaceSizeTools {
    func LXFDiskSpaceFree() -> Int {
        //    var error: Error = nil
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else {
            return -1
        }
        guard let space = attrs.index(forKey: .systemFreeSize) else {
            return -1
        }
        guard let freeSpace = attrs.values[space] as? Int else {
            return -1
        }
        return freeSpace
    }
}

// MARK:- 获取空间大小对应的文字说明
extension SpaceSizeTools {
    func LXFDiskSpaceFreeString(size: Int) -> String {
        let size:CGFloat      = CGFloat(size)
        let sizeUnit: CGFloat = 1024.0
        if size < sizeUnit { // B
            return String(format: "%lldB", size)
        } else if size < sizeUnit * sizeUnit {  // KB
            return String(format: "%.1fKB", size / sizeUnit)
        } else if size < sizeUnit * sizeUnit * sizeUnit {   // MB
            return String(format: "%.1fMB", size / (sizeUnit * sizeUnit))
        } else{ // GB
            return String(format: "%.1fG", size / (sizeUnit * sizeUnit * sizeUnit))
        }
    }
}


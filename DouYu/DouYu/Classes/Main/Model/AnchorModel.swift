//
//  AnchorModel.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    ///房间ID
    var room_Id: Int = 0
    ///房间图片对应的URLString
    var vertical_src: String = ""
    ///判断是手机还是电脑 0:电脑直播  1:手机直播
    var isVertical: Int = 0
    ///房间名称
    var room_name: String = ""
    ///主播昵称
    var nickname: String = ""
    ///观看人数
    var online: Int = 0
    ///所在城市
    var anchor_city: String = ""
    
    //KVC赋值
    init(dic: [String: NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}

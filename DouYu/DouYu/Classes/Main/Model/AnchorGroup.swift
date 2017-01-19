//
//  AnchorGroup.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    
    //懒加载属性
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    ///该组中对应的房间信息
    var room_list:[[String: NSObject]]?{
    
        // 属性监听器
        didSet{
            guard let room_list = room_list else{return}
            
            for dict in room_list {
                anchors.append(AnchorModel(dic: dict))
            }
                    }
    }
    ///组显示的标题
    var tag_name: String = ""
    ///组显示的图标
    var icon_name: String = "home_header_phone"
    ///游戏图标
    var icon_url: String = ""
    
    override init() {
        
    }

    init(dic: [String: NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}

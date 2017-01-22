//
//  GameModel.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/21.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    
    //自定义属性
    var tag_name: String = ""
    var icon_url:String = ""
    
    //自定义构造函数
    init(dict :[String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }

    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}

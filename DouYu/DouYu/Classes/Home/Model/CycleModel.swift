//
//  CycleModel.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/17.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    
    
    
    ///标题
    var title: String = ""
    ///展示图片的地址
    var pic_url: String = ""
    ///主播信息对应的字典
    var room: [String: NSObject]?{
        didSet{
            guard let  room = room else {return}
            anchor = AnchorModel(dic: room)
        }
    }
    ///主播信息对应的模型
    var anchor: AnchorModel?

    //自定义构造函数
    init(dic: [String: NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}

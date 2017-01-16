//
//  CollectionPrettyCell.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {


    @IBOutlet weak var cityBtn: UIButton!
    
    
   override var anchor: AnchorModel?{
    
        didSet{
            //将属性传给父类
            super.anchor = anchor

            //城市显示
            cityBtn.setTitle(anchor?.anchor_city, forState: .Normal)
        }
    }
    
        
   
}

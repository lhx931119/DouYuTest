//
//  CollectionCycleCell.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/17.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    //控件属性
    
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icnImageView: UIImageView!
    //定义模型属性
    var  cycleModel: CycleModel?{
        didSet{
        
        titleLabel.text = cycleModel?.title
        let iconUrl = NSURL(string: cycleModel?.icon_url ?? "")
            icnImageView.kf_setImageWithURL(iconUrl!)
            
            
        }
    }
}

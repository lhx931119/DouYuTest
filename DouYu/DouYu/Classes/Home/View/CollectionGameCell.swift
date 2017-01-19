//
//  CollectionGameCell.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/19.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    
    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //定义属性
    var group: AnchorGroup?{
        
        didSet{
            
            titleLabel.text = group?.tag_name
            let icnUrl = NSURL(string: group?.icon_url ?? "")!
            
            iconImageView.kf_setImageWithURL(icnUrl, placeholderImage: UIImage(named: "home_more"))
        }
    }
    //系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

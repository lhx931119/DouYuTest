//
//  CollectionHeaderView.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var group: AnchorGroup?{
    
        didSet{
            titleLabel.text = group?.tag_name
            headImage.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}

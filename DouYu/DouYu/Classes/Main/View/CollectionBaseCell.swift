//
//  CollectionBaseCell.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/16.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameBtn: UIButton!
    @IBOutlet weak var icnImageView: UIImageView!

    
    var anchor: AnchorModel?{
        didSet{
            //检验是否有值
            guard let anchor = anchor else{return}
            //取出在线人数显示的文字
            var onlineStr: String = ""
            if anchor.online >= 10000  {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, forState: .Normal)
            //昵称的显示
            nickNameBtn.setTitle(anchor.nickname, forState: .Normal)
            //图片显示
            guard  let imageUrl = NSURL(string: anchor.vertical_src) else {return}
            icnImageView.kf_setImageWithURL(imageUrl)
        }
    }

}

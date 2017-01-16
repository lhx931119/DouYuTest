//
//  CollectionNormalCell.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    
//    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
   
//    @IBOutlet weak var nickNameBtn: UIButton!
//    @IBOutlet weak var icnImageView: UIImageView!
//    
 override   var anchor: AnchorModel?{
        
        didSet{
            
            //将属性传给父类
            super.anchor = anchor
//            //检验是否有值
//            guard let anchor = anchor else{return}
//            //取出在线人数显示的文字
//            var onlineStr: String = ""
//            if anchor.online >= 10000  {
//                onlineStr = "\(Int(anchor.online/10000))万在线"
//            }else{
//                onlineStr = "\(anchor.online)在线"
//            }
//            onlineBtn.setTitle(onlineStr, forState: .Normal)
//            //昵称的显示
//            nickNameBtn.setTitle(anchor.nickname, forState: .Normal)
   //        房间名称显示
            roomNameLabel.text = anchor?.room_name
            //图片显示
//            guard  let imageUrl = NSURL(string: anchor.vertical_src) else {return}
//            icnImageView.kf_setImageWithURL(imageUrl)
        }
    }
    
}

//
//  UIBarItem-Extention.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/13.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

   //构造函数 1>convenience开头 2>必须调用设计结构的一个函数
    convenience init(imageName:String, highImageName:String = "", size:CGSize = CGSizeZero){
    
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        if size == CGSizeZero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPointZero, size: size)
        }
        self.init(customView:btn)
    }

}
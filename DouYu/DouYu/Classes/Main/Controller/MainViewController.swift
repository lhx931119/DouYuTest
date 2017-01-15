//
//  MainViewController.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/13.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
         addChildVc("Live")
         addChildVc("Attention")
         addChildVc("Discover")
        addChildVc("Me")
        
        
    }

    
    
    private func addChildVc(storyName:String){
        
        //通过storyBoard创建控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //添加控制器
        addChildViewController(childVc)
        

    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}

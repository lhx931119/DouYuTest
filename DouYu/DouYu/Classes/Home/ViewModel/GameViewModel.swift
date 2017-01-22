//
//  GameViewModel.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/21.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

class GameViewModel{
    
    lazy var gameModels: [GameModel] = [GameModel]()
    
   
}
// Mark:-请求数据
extension GameViewModel{

     func loadGameData(finshedCallBack:()->()){
        
        
        NetWorkTools.requestForData(.GET, urlString: kDouYuHost + kColumdetailHost, parpams: ["shortName":"game"]) { (result) in
            //取出数据
            guard  let resultDic = result as? [String: AnyObject] else {return}
            guard  let dataArray = resultDic["data"] as? [[String: AnyObject]] else {return}
            //字典转模型
            for dict in dataArray{
                self.gameModels.append(GameModel(dict: dict))
            }
            //完成回调
            finshedCallBack()
        }
    }
}

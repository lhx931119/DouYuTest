//
//  RecommendViewModel.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit


class RecommendViewModel{
    
    //懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()

}

// Mark:-网络数据请求

extension RecommendViewModel{

    //请求推荐数据
    func requestData(finishCallBack:()->()){
        //定义参数
        let parpams = ["limit" : "4", "offset" : "0", "time": NSDate.getCurrentTime()]
        
        //创建dispatchGroup
        let dGroup = dispatch_group_create()
        
        //请求第一部分推荐数据
        // 进入组
        dispatch_group_enter(dGroup)
        NetWorkTools.requestForData(.GET, urlString: kDouYuHost + kbigDataRoomHost, parpams: ["time": NSDate.getCurrentTime()]) { (result) in
            // 将result转化为字典
            guard let resultDic = result as? [String: NSObject] else {return}
            //根据data该key,获取数组
            guard let dataAry = resultDic["data"] as? [[String:NSObject]] else {return}
           
            //设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //遍历数组取出字典，将字典转化为模型对象
            for dic in dataAry{
                let anchor = AnchorModel(dic: dic)
                self.bigDataGroup.anchors.append(anchor)
            }
            //离开组
            dispatch_group_leave(dGroup)
        }
        
        //请求第二部分颜值数据
        // 进入组
        dispatch_group_enter(dGroup)
        NetWorkTools.requestForData(.GET, urlString: kDouYuHost + kVerticaHost, parpams: parpams) { (result) in
            // 将result转化为字典
            guard let resultDic = result as? [String: NSObject] else {return}
            //根据data该key,获取数组
            guard let dataAry = resultDic["data"] as? [[String:NSObject]] else {return}
            
            //设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //遍历数组取出字典，将字典转化为模型对象
            for dic in dataAry{
                let anchor = AnchorModel(dic: dic)
                self.prettyGroup.anchors.append(anchor)
            }
            //离开组
            dispatch_group_leave(dGroup)
        }

        //请求2-12部分游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1484480903
        // 进入组
        dispatch_group_enter(dGroup)
        NetWorkTools.requestForData(.GET, urlString: kDouYuHost + kHotCateHost, parpams: parpams) { (result) in
            
            // 将result转化为字典
            guard let resultDic = result as? [String: NSObject] else {return}
            
            //根据data该key,获取数组
            guard let dataAry = resultDic["data"] as? [[String:NSObject]] else {return}
            //遍历数组取出字典，将字典转化为模型对象
            for dic in dataAry{
                let group = AnchorGroup(dic: dic)
                self.anchorGroups.append(group)
            }
            //离开组
            dispatch_group_leave(dGroup)
        }
        
        //所有的数据都请求到后排序
        dispatch_group_notify(dGroup, dispatch_get_main_queue()) {
            self.anchorGroups.insert(self.prettyGroup, atIndex: 0)
            self.anchorGroups.insert(self.bigDataGroup, atIndex: 0)
            finishCallBack()
        }
    }
    
    // 请求无限轮播数据
    func requestCycleData(finishCallBack:()->()){
        NetWorkTools.requestForData(.GET, urlString: kDouYuHost + kCycleViewHost, parpams: ["version":"2.300"]) { (result) in
            print(result)
            
            finishCallBack() 
        }
        
        
        
    }
}

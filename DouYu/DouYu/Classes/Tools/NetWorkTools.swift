//
//  NetWorkTools.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

import Alamofire

enum MethodType {
    case GET
    case POST
}


class NetWorkTools{
    
    class func requestForData(methodType: MethodType, urlString: String, parpams: [String: NSString]? = nil, finishCallBack:(result: AnyObject)->()){

        //获取类型
        let method = methodType == .GET ? Method.GET : Method.POST
        Alamofire.request(method, urlString).responseJSON { (response) in
            guard let result = response.result.value else{
                
                print(response.result.error)
                return
            }
            finishCallBack(result: result)
            
        }
    }

}

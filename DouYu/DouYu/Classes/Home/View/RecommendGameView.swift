

//
//  RecommendGameView.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/19.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin: CGFloat = -15



class RecommendGameView: UIView {

    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //定义属性
    var group: [AnchorGroup]?{
        didSet{
            //移除前两个
            group?.removeFirst()
            group?.removeFirst()
            
            //添加更多
            let moreGroup = AnchorGroup()
            group?.append(moreGroup)
            
            //刷新collectionView
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //设置不随父空间拉伸而拉伸
        autoresizingMask = .None
        
       // 注册cell
        collectionView.registerNib(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// Mark:-快速创建的类方法
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return NSBundle.mainBundle().loadNibNamed("RecommendGameView", owner: nil, options: nil).first as! RecommendGameView
    }
}

// Mark:-遵守collectionViewDataSource
extension RecommendGameView: UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kGameCellID, forIndexPath: indexPath) as! CollectionGameCell
        cell.group = group?[indexPath.item]
        
        return cell
        
    }

}







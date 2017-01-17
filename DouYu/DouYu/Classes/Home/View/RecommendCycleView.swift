//
//  RecommendCycleView.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/17.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {

    @IBOutlet weak var collection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件拉伸而拉伸
        autoresizingMask = .None
        
        //注册cell
        collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier:  kCycleCellID)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collection.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        collection.pagingEnabled = true
    }
}


// Mark:-快速创建view的类方法
extension RecommendCycleView{

    class func recommendCycleView() ->RecommendCycleView {
        return NSBundle.mainBundle().loadNibNamed("RecommendCycleView", owner: nil, options: nil).first as! RecommendCycleView
        
    }
}

// Mark:-遵守UICollectionView的dataSource
extension RecommendCycleView: UICollectionViewDataSource{


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
}








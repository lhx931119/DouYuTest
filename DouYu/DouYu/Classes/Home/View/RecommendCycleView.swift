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
    
    
    //定义属性
    var cycleTimer: NSTimer?
    var cycleModels: [CycleModel]?{
    
        didSet{
            //刷新collectionView
            collection.reloadData()
            
             //设置pageController的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //设置collectionView默认滚动位置
            let indexPath = NSIndexPath(forItem:(cycleModels?.count ?? 0) * 10, inSection: 0)
            
            collection.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件拉伸而拉伸
        autoresizingMask = .None
        
        //注册cell
        
        collection.registerNib(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
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
        return (cycleModels?.count ?? 0) * 10000
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //取出模型
        let cycleModel = cycleModels![(indexPath.item) % (cycleModels?.count)!]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModel
        return cell
    }
}

// Mark:-遵守UICollectionView的delegate
extension RecommendCycleView: UICollectionViewDelegate{

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentOffX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
      pageControl.currentPage =  Int(currentOffX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
            removeCycleTimer()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            addCycleTimer()
    }
    
}
// Mark:-对定时器的操作方法

extension RecommendCycleView{

    private func addCycleTimer(){
        cycleTimer = NSTimer(timeInterval: 3.0, target: self, selector: #selector(scrollNext), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(cycleTimer!, forMode: NSRunLoopCommonModes)
    
    }
    
    @objc  private func scrollNext(){
        
        //获取滚的偏移量
        let courrentOffx = collection.contentOffset.x
        let offetX = courrentOffx + self.collection.bounds.width
        //滚动到该位置
        self.collection.setContentOffset(CGPoint(x:offetX , y:0), animated: true)
    }
    
    private func removeCycleTimer(){
        ///运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
}




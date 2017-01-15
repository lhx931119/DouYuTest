//
//  PageContentView.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/13.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate: class {
    
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, oldIndex: Int, targetIndex: Int)
}


private let cellIdentifier = "cellIdentifier"

class PageContentView: UIView {

    //定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startoffX: CGFloat = 0
    private var isForbid: Bool = false
 
    weak var delegate: PageContentViewDelegate?
     //定义懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in
    
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        return collectionView
        
    }()
    
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //创建UI界面
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView{

    private func setUI(){
    
     //将所有的子控制器放入父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
    //添加collectionView,用于在cell中存放控制器的view
      addSubview(collectionView)
        collectionView.frame = self.bounds
        
    }
}



extension PageContentView: UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //创建cell
       let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        //给cell添加内容
        
        for vc in cell.contentView.subviews {
            vc.removeFromSuperview()
        }

        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }

}

extension PageContentView: UICollectionViewDelegate{

    
    
    
    
    
    //开始滑动
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        isForbid = false
        startoffX = scrollView.contentOffset.x

    }
    
    //结束滑动
    func scrollViewDidScroll(scrollView: UIScrollView) {
       
        if isForbid {
            return
        }
        
         var progress: CGFloat = 0
         var targetIndex: Int = 0
         var oldIndex: Int = 0

        let scrollViewW: CGFloat = scrollView.bounds.width
        let currentoffsetX = scrollView.contentOffset.x
        if currentoffsetX > startoffX {
            //向左滑
        //计算progress
            progress = currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW)
        //计算原先idnex
            oldIndex = Int(currentoffsetX / scrollViewW)
        //计算目标index
            targetIndex = oldIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //完全滑过
            if currentoffsetX - startoffX == scrollViewW {
                progress = 1
                targetIndex = oldIndex
            }
        }else{
            //向右滑
            progress =  1 - (currentoffsetX / scrollViewW - floor(currentoffsetX / scrollViewW))
            //计算目标index
            targetIndex = Int(currentoffsetX / scrollViewW)
            //计算当前index
             oldIndex = targetIndex + 1
            
            if oldIndex >= childVcs.count {
                oldIndex = childVcs.count - 1
 
            }
 
        }
        delegate?.pageContentView(self, progress: progress, oldIndex: oldIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {

    func setCurrenIndex(currentIndex: Int){
        isForbid = true
        let offsetX = CGFloat(currentIndex) * frame.size.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}





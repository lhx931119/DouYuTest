//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/15.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

private let kItemMagin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3 * kItemMagin) / 2
private let kItemNormalH: CGFloat = kItemW * 3 / 4
private let kItemPrettyH: CGFloat = kItemW * 4 / 3
private let kHeadViewH: CGFloat = 50
private let kCycleViewH = kScreenW * 3 / 8

private let kNormalCellID = "kNormalCellID"
private let kPrettylCellID = "kPrettylCellID"

private let kHeadViewID = "kHeadViewID"
class RecommendViewController: UIViewController {

    
    
    //懒加载属性
    
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var recommendVM:RecommendViewModel = RecommendViewModel()

    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemNormalH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMagin
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        
        
    let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)

        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        

        collectionView.registerNib(UINib(nibName: "CollectionNormalCell", bundle: nil)
            , forCellWithReuseIdentifier:kNormalCellID)
        
        collectionView.registerNib(UINib(nibName: "CollectionPrettyCell", bundle: nil)
            , forCellWithReuseIdentifier:kPrettylCellID)


        collectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
            return collectionView
    }()
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purpleColor()
        //设置UI
        setUI()
        
        //请求数据
        loadData()
        
   }

}




// Mark:-设置UI
extension RecommendViewController {

    private func setUI(){
        //添加collectionView
        view.addSubview(collectionView)
        
//       添加cycleView
        collectionView.addSubview(cycleView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top:kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}


// Mark:-请求数据
extension RecommendViewController{
    
    private func loadData(){
        //请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        //请求无限轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
         }
    }
}

// Mark:- 遵守collectionDataSource
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //定义cell
        var cell: CollectionBaseCell!
        
        //取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettylCellID, forIndexPath: indexPath) as! CollectionPrettyCell

        }else{
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! CollectionNormalCell
        }
        
        //给模型赋值
        cell.anchor = anchor
        return cell

    
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeadViewID, forIndexPath: indexPath) as! CollectionHeaderView
        headView.group = recommendVM.anchorGroups[indexPath.section]
        return headView
    } 
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
    
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemPrettyH)
        }else{
            return CGSize(width: kItemW, height: kItemNormalH)
        }
    }
}














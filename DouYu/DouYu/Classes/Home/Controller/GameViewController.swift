//
//  GameViewController.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/19.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

private let kEdeMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - kEdeMargin * 2) / 3
private let kItemH: CGFloat = kItemW * 6 / 5

private let kGameCellID = "kGameCellID"

class GameViewController: UIViewController {

    //定义属性
    private lazy var models: [GameModel] = [GameModel]()
    private lazy var gameModel: GameViewModel = {
        let gameModel = GameViewModel()
        return gameModel
    }()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdeMargin, bottom: 0, right: kEdeMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    //系统回调函数
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        collectionView.registerNib(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        view.backgroundColor = UIColor.purpleColor()
        //添加UI
        setUI()
        
        //加载游戏数据
        loadGameAllData()
        
        
    }
}

// Mark:- 设置UI
extension GameViewController{

    private func setUI(){
    
        view.addSubview(collectionView)
    }

}

// Mark:-加载数据
extension GameViewController{

    private func loadGameAllData(){
        
      gameModel.loadGameData { 
            self.models = self.gameModel.gameModels
        }
    }
}


// Mark:-遵守UiCollectionView  dataSource

extension GameViewController: UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kGameCellID, forIndexPath: indexPath) as! CollectionGameCell
        cell.model = self.models[indexPath.item]
        return cell
    }
}








//
//  HomeViewController.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/13.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {
    
    private lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH, width:kScreenW , height: kTitleViewH)
        let titles = ["推荐","手游","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        titleView.backgroundColor = UIColor.whiteColor()
        return titleView
    
    }()
    
    
    private lazy var pageContentView:PageContentView = {[weak self] in
    
        
        let contentH = kScreenH - kStatusBarH - kNavgationBarH - kTitleViewH - kTabBarH
        
        
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        
        //确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0...3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)

        contentView.delegate = self
        
        return contentView
    }()
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setUI()
        
      
    }

}


// mark: 设置UI界面
extension HomeViewController{

    //设置UI
    private func setUI(){
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏
        setNavigationBar()
        
        //添加TitleView
        view.addSubview(pageTitleView)
        
         //添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purpleColor()
    }
    
    //设置NavigationBar
    private func setNavigationBar(){
        
        
    
        //设置导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
               //设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        
        //设置右边item
        let size = CGSize(width: 40, height: 40)
        let hostoryItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "", size: size)
        let scanItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "", size: size)
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "", size: size)
        navigationItem.rightBarButtonItems = [hostoryItem,scanItem,searchItem]
    }
}


extension HomeViewController: PageTitleViewDelegate{

    func pageTitleView(titleView: PageTitleView, selectIndex: Int) {
        pageContentView.setCurrenIndex(selectIndex)
    }
}


extension HomeViewController: PageContentViewDelegate{

    
    
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, oldIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitileOffsetX(progress, oldIndex: oldIndex, targetIndex: targetIndex)
    }
}






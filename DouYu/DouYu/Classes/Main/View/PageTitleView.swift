//
//  PageTitleView.swift
//  DouYu
//
//  Created by 李宏鑫 on 17/1/13.
//  Copyright © 2017年 hongxinli. All rights reserved.
//

import UIKit


// Mark:- 定义颜色元祖

private let kNormalColors: (CGFloat, CGFloat, CGFloat) = (85,85,85)
private let kSelectColors: (CGFloat, CGFloat, CGFloat) = (255,128,0)

private let kScrollLineH: CGFloat = 2


protocol PageTitleViewDelegate: class {
    
    func pageTitleView(titleView: PageTitleView, selectIndex: Int)
}


class PageTitleView: UIView {

    //定义属性
    private var titles: [String]
    private var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    //懒加载属性
    private lazy var scrollView: UIScrollView = {
           let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    
    private lazy var titleLabels: [UILabel] = [UILabel]()
    //自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles;
        super.init(frame: frame)
        
        //创建UI
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension PageTitleView{
    //设置UI界面
    private func setUI(){
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的label
        setUpTitleLabels()
        
        //设置底线合滑块
        setUpBottomLineAandMenue()
    }
    
    private func setUpTitleLabels(){
        
        //label的一些确定属性
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0

        
        for (index, title) in titles.enumerate(){
            //创建label
            let label = UILabel()
            //设置 label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16.0)
            label.textColor = UIColor(r: kNormalColors.0, g: kNormalColors.1, b: kNormalColors.2)
            label.textAlignment = .Center
            //设置label的frame
                       let labelX: CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //将label添加到scrollView
            scrollView.addSubview(label)
            titleLabels.append(label);
            
            //给label添加手势
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    

    private func setUpBottomLineAandMenue(){
    
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.whiteColor()
        let lineH: CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //获取第一个label
        guard let firstLabel :UILabel = titleLabels.first else {return}
        
        firstLabel.textColor = UIColor(r: kSelectColors.0, g: kSelectColors.1, b: kSelectColors.2)
        
        //添加scrollLine
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}



// Mark:-label点击事件
extension PageTitleView{
    @objc private func titleLabelClick(tapGes: UIGestureRecognizer){
        //获取当前label
        guard  let currentLabel = tapGes.view as? UILabel else{return}
        //如果点击同一个title，直接返回
        if currentLabel.tag == currentIndex {return}
        //获取上一个label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectColors.0, g: kSelectColors.1, b: kSelectColors.2)
        oldLabel.textColor = UIColor(r: kNormalColors.0, g: kNormalColors.1, b: kNormalColors.2)
        
        //更新currentIndex
        currentIndex = currentLabel.tag

        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        
        UIView.animateWithDuration(0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(self, selectIndex: currentIndex)
    }
}


extension PageTitleView{

    func setTitileOffsetX(progress: CGFloat, oldIndex: Int, targetIndex: Int) {
        
      
        
        //去除label
        let oldLabel = titleLabels[oldIndex]
        let targetLabel = titleLabels[targetIndex]
 
        
        //设置滑块
        let moveTotal = targetLabel.frame.origin.x - oldLabel.frame.origin.x
        let moveX = moveTotal * progress
        self.scrollLine.frame.origin.x = oldLabel.frame.origin.x + moveX
        
        //颜色变化范围
        let totalColors = (kSelectColors.0 - kNormalColors.0, kSelectColors.1 - kNormalColors.1,kSelectColors.2 - kNormalColors.2)
        
        let rNor = kSelectColors.0 - totalColors.0 * progress
        let gNor = kSelectColors.1 - totalColors.1 * progress
        let bNor = kSelectColors.2 - totalColors.2 * progress
    
        let rSel = kNormalColors.0 + totalColors.0 * progress
        let gSel = kNormalColors.1 + totalColors.1 * progress
        let bSel = kNormalColors.2 + totalColors.2 * progress

        //变化原先的
         oldLabel.textColor = UIColor(r: rNor, g: gNor, b: bNor)
        //变化目标的
        targetLabel.textColor = UIColor(r: rSel, g: gSel, b: bSel)
        //记录最新index
        currentIndex = targetIndex
    }
}





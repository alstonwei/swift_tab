//
//  QYTabbar.swift
//  QYProject
//
//  Created by epailive on 17/2/16.
//  Copyright © 2017年 epailive. All rights reserved.
//

import UIKit

let topicColor = UIColor.init(colorLiteralRed: 255/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1)
let normalColor = UIColor.white

class QYTabBarItem: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(frame: CGRect,title:String) {
        super.init(frame: frame)
        
        self.layer.borderColor = topicColor.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor = topicColor
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(UIColor.white, for: UIControlState.selected)
        self.setTitleColor(topicColor, for: UIControlState.normal)
        self.backgroundColor = normalColor
    }
}


class QYTabBar: UIView {
    var selectIndex:Int = 0;
    var selectItem:UIButton?
    var itemSpacing: CGFloat = 5
    var verticalSpacing: CGFloat = 5
    var itemCornerRedius: CGFloat = 0
    var delegate : QYTabBarDelegate?{
        didSet{
            layoutSubviews()
        }
    }
    override func layoutSubviews() {
        
        for sub in self.subviews{
            sub.removeFromSuperview()
        }
        
        if (self.delegate != nil){
            let count = delegate?.tabBar(self, numberOfItems: 0)
            let totalSpacing = itemSpacing * CGFloat(count!+1)
            let itemW = (self.frame.size.width - totalSpacing) / CGFloat(count!)
            let itemH = self.frame.size.height - verticalSpacing * 2
            for index in 0...2 {
                let title = delegate?.tabBar(self, titleForItemAt: index)
                let size = CGSize.init(width: itemW, height: itemH)
                let point = CGPoint.init(x: CGFloat(CGFloat(index) * (size.width + itemSpacing)) + itemSpacing, y: verticalSpacing)
                let item = QYTabBarItem.init(frame:CGRect.init(origin: point, size: size),title: title!)
                item.layer.cornerRadius = self.itemCornerRedius
                item.addTarget(self, action: #selector(itemClicked), for: UIControlEvents.touchUpInside)
                item.tag = index
                self.addSubview(item)
                if(index == selectIndex)
                {
                    updateSelect(item: item)
                }
                
            }
        }
    }
    
    /// 更新选中的
    ///
    /// - parameter item:
    func updateSelect(item:QYTabBarItem)  {
        if selectItem != nil {
            selectItem?.isSelected = false
            selectItem?.backgroundColor = normalColor
        }
        
        item.isSelected = true
        selectItem = item;
        selectIndex  = item.tag
        item.backgroundColor = topicColor
    }
    
    /// 点击时间
    ///
    /// - parameter item:
    func itemClicked(item:QYTabBarItem)
    {
        updateSelect(item: item)
        if self.delegate != nil{
            self.delegate?.tabBar(self, didSelectItemAt: item.tag)
        }
        
    }
}

protocol  QYTabBarDelegate{
    func tabBar(_ tabBar: QYTabBar, didSelectItemAt index: Int)
    
    func tabBar(_ tabBar: QYTabBar, didDeselectItemAt index: Int)
    
    func tabBar(_ tabBar: QYTabBar, numberOfItems index: Int) -> Int
    
    func tabBar(_ tabBar: QYTabBar, titleForItemAt index: Int) -> String
    
}

//
//  QYTabbar.swift
//  QYProject
//
//  Created by epailive on 17/2/16.
//  Copyright © 2017年 epailive. All rights reserved.
//

import UIKit

class QYTabBarItem: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(frame: CGRect,title:String) {
        super.init(frame: frame)
        let topicColor = UIColor.init(colorLiteralRed: 223, green: 89, blue: 88, alpha: 1)
        self.layer.borderColor = topicColor.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.textColor =  topicColor
        self.setTitle(title, for: UIControlState.normal)
    }
}


class QYTabBar: UIView {
    var delegate : QYTabBarDelegate?{
        didSet{
            layoutSubviews()
        }
    }
    override func layoutSubviews() {
        if (self.delegate != nil){
            let count = delegate?.tabBar(self, numberOfItems: 0)
            let itemW = self.frame.size.width / CGFloat(count!)
            let itemH = self.frame.size.height
            for index in 0...2 {
                let title = delegate?.tabBar(self, titleForItemAt: index)
                let size = CGSize.init(width: itemW, height: itemH)
                let item = QYTabBarItem.init(frame:CGRect.init(origin: CGPoint.init(x: CGFloat(CGFloat(index) * size.width), y: 0), size: size),title: title!)
                item.addTarget(self, action: #selector(itemClicked), for: UIControlEvents.touchUpInside)
                item.tag = index
                self.addSubview(item)
                
            }
        }
    }
    
    
    func itemClicked(item:QYTabBarItem)
    {
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

//
//  UIBarButtonItem-Extension.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /// 自定义导航栏按钮
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - fontSize: 标题大小
    ///   - target: 响应者
    ///   - action: 响应事件
    ///   - isBack: 是否是返回按钮
    convenience init(title:String,fontSize:CGFloat = 16,target:AnyObject,action:Selector,isBack:Bool) {
        let btn :UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage.init(named: imageName), for: UIControlState(rawValue:0))
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}

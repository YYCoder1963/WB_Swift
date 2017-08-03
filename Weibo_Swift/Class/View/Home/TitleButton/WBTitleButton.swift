//
//  WBTitleButton.swift
//  Weibo_Swift
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {
    init(title: String?) {
        super.init(frame: CGRect())
        if title == nil {
            setTitle("首页", for: [])
        } else {
            setTitle(title, for: [])
            setImage(UIImage(named:"navigationbar_arrow_down"), for: [])
            setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
        }
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: [])
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//
//  WBStatus.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import YYModel
class WBStatus: NSObject {

    var id: Int64 = 0
    var text: String?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    
}

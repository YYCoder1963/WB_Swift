//
//  Bundle-Extension.swift
//  Swift_第三天
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

extension Bundle{
    
//    func namespace() -> String {
//        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
//    }
    var namespace :String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}

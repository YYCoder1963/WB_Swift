//
//  WBUserAccount.swift
//  Weibo_Swift
//
//  Created by apple on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

private let accountFile:NSString = "useraccount.json"

class WBUserAccount: NSObject {
    
    var access_token : String?
    //过期时间，开发者5年，使用者3天
    var expires_in : TimeInterval = 0
    var uid : String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        guard let path = accountFile.cz_appendDocumentDir(),
        let data = NSData(contentsOfFile: path),
        let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) else { return  }
        yy_modelSet(with: dict as! [AnyHashable : Any])
        
        
    }
    
    func saveAccount() {
        let dict = (self.yy_modelToJSONObject() as? [String:AnyObject]) ?? [:]
        guard let data = try?JSONSerialization.data(withJSONObject: dict, options: []),
            let filePath = accountFile.cz_appendDocumentDir()
            else { return }
        (data as NSData).write(toFile: filePath, atomically: true)
        print("账户保存成功 \(filePath)")
    }
    
}

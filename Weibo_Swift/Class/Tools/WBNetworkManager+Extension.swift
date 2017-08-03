//
//  WBNetworkManager+Extension.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/19.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

extension WBNetworkManager{
    
    
    func statusList(max_id: Int64 = 0,since_id: Int64 = 0, completion:@escaping (_ list:[[String:AnyObject]]?,_ isSuccess:Bool) -> ()){
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["since_id":"\(since_id)",
            "max_id":"\(max_id > 0 ? max_id - 1 : 0)"
                     ]
        
        tokenRequest(urlString: urlStr, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            let result = json as? [String:AnyObject]
            let statuses = result?["statuses"] as? [[String:AnyObject]]
            completion(statuses, isSuccess)
        }

    }
    
    func unreadCount(completion:@escaping (_ count: Int) -> ()) {
        guard let uid = userAccount.uid else { return  }
        let urlStr = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid":uid]
        
        tokenRequest(urlString: urlStr, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            let dict = json as? [String:AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        }
    }
}

//MARK: --OAuth相关
extension WBNetworkManager {
    func loadAccessToken(code:String) {
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":WBAppKey,
                      "client_secret":WBAppSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":WBRedirectURL]
        request(method: WBHttpMethod.POST, urlString: urlStr, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            print("token:\(String(describing: json))")
            
            //字典转模型
            self.userAccount.yy_modelSet(withJSON: json ?? [:])
            self.userAccount.saveAccount()
        }
           
    }
}



























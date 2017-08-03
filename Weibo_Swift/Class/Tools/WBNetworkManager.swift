//
//  WBNetworkManager.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/17.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import AFNetworking

enum WBHttpMethod {
    case GET
    case POST
}
//2978805170
//25e417f2b72aea6679e3eaae162d5f60
//http://www.baidu.com
class WBNetworkManager: AFHTTPSessionManager {
    static let shared = { () -> WBNetworkManager in
        let instance = WBNetworkManager()
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()
    
    lazy var userAccount = WBUserAccount()
//    var accessToken: String? = "2.00a3XzyBgSlaPDe85b4bcd2abkjwwC"
//    var uid: String? = "1073880650"
    var userLogon :(Bool) {
         return userAccount.access_token != nil
    }
    
    func tokenRequest(method:WBHttpMethod = .GET,urlString:String,parameters:[String:AnyObject]?,completion:@escaping (_ json:Any?,_ isSuccess:Bool) -> ()) -> () {
        guard let token = userAccount.access_token else {
            print("没有token，需要登录")
            completion(nil, false)
            return
        }
        
        var parameters = parameters
        
        if parameters == nil {
            parameters = [String:AnyObject]()
        }
        
        parameters!["access_token"] = token as AnyObject
        
        request(urlString: urlString, parameters: parameters, completion: completion)
    }
    
    
    func request(method:WBHttpMethod = .GET,urlString:String,parameters:[String:AnyObject]?,completion:@escaping (_ json:Any?,_ isSuccess:Bool) -> ())  {
        let success = {(task:URLSessionDataTask,json:Any?) -> () in
            completion(json, true)
            print(json ?? "")
        }
        
//        let failure = {(task:URLSessionDataTask?,error:NSError) -> () in
//            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
//                print("token过期")
//            }
//           completion(nil, false)
//        }
        
        
       
        if method == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure:{ (task:URLSessionDataTask?,error:NSError) in
                print("\(error)")
                if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                    print("token过期")
                }
                completion(nil, false)
                } as? (URLSessionDataTask?, Error) -> Void)
//            get(urlString, parameters: parameters, progress: nil, success:success, failure: failure as? (URLSessionDataTask?, Error) -> Void)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure:{ (task:URLSessionDataTask?,error:NSError) in
                print("\(error)")
                if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                    print("token过期")
                }
                completion(nil, false)
                } as? (URLSessionDataTask?, Error) -> Void)
//            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure as? (URLSessionDataTask?, Error) -> Void)
        }
        
    
    }
    
}

//
//  WBStatusListViewModel.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation


fileprivate let pullUpMaxErrorTime = 2
/// 父类的选择，如果类需要使用‘KVC’或者字典转模型框架设置对象值，类需要继承自NSObject

/// 如果类只是包装一些代码逻辑，可以不用任何父类，好处：更加轻量级
class WBStatusListViewModel {
    
    lazy var statusList = [WBStatus]()
    private var pullUpErrorTime = 0
    
    func loadStatus(isPullUp:Bool,completion:@escaping (_ isSuccess: Bool,_ hasMorePullUp:Bool) -> ()) {
        
        if isPullUp && pullUpErrorTime > pullUpMaxErrorTime  {
            completion(true,false)
            return
        }
        
        
        let sinceId = isPullUp ? 0 : (statusList.first?.id ?? 0)
        let max_id = isPullUp ? (statusList.last?.id ?? 0) : 0
        
        WBNetworkManager.shared.statusList(max_id: max_id,since_id: sinceId) { (list, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else{
                completion(isSuccess, false)
                return
            }
            print("刷新了\(array.count)条")
            if isPullUp {
                self.statusList += array
            }else{
                //下拉刷新应该将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            if isPullUp && array.count == 0{
                self.pullUpErrorTime += 1
                completion(isSuccess, false)
            }else{
                completion(isSuccess, true)
            }
            
        }
    }
}

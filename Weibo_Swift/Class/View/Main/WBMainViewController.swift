//
//  WBMainViewController.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    fileprivate var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setUpControllers()
        setUpComposeButton()
//        setUpTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name:NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    /**
       - 因为 nav 和 VC 都是由tabbarcontroller控制，所以在此设置竖屏nav和VC都会竖屏
       - 使用代码控制设备方向，可以在需要横屏的时候单独处理
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    @objc private func userLogin(n:Notification){
        print("用户登录通知:\(n)")
        let nav = UINavigationController.init(rootViewController: WBOAuthViewController())
        present(nav, animated: true, completion: nil)
    }
    
    @objc func composeStatus(){
        print("撰写微博")
        //测试
//        let vc = UIViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        present(nav, animated: true, completion: nil)
//        
        
    }
    
    /// 撰写按钮
    lazy var composeBtn :UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    
}

private extension WBMainViewController{

//    @objc func userLogon() {
//        
//    }
    func setUpTimer() {
        if !WBNetworkManager.shared.userLogon {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        WBNetworkManager.shared.unreadCount { (count) in
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            UIApplication.shared.applicationIconBadgeNumber = count
            print("未读\(count)")
        }
    }
}

extension WBMainViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let idx = childViewControllers.index(of: viewController)
        
        //当前索引是0，同时将要点击的索引也是0时刷新首页
        if selectedIndex == 0 && idx == selectedIndex {
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                vc.loadData()
            })
            print("点击首页")
        }
        return !viewController.isMember(of: UIViewController.self)
        
    }
}

// MARK: - 设置控制器
private extension WBMainViewController{
    
    /// 添加撰写按钮
    func setUpComposeButton(){
        let width = tabBar.bounds.width/CGFloat(childViewControllers.count)
        composeBtn.frame = tabBar.bounds.insetBy(dx: width * 2, dy: 0)
        tabBar.addSubview(composeBtn)
        composeBtn.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    
    
    /// 设置自控制器
    func setUpControllers() -> () {
        
        /// 从本地json加载控制器配置信息
        
        /// 推荐try?(弱try)，如果解析成功就有值，否则为nil；不推荐try!(强try)，如果解析成功就有值，否则崩溃；
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil) ,
            let data = NSData(contentsOfFile: path),
            let arr = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String:AnyObject]]
        else{
             return
        }
        
        
        var arrayM = [UIViewController]()
        
        for dict in arr! {
            arrayM.append(getController(dict: dict as [String : AnyObject]))
        }
        viewControllers = arrayM
    }
    
    
    /// 设置控制器属性
    ///
    /// - Parameter dict: 控制器属性信息
    /// - Returns: 返回设置后的控制器
    func getController(dict: [String : AnyObject]) -> UIViewController {
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? WBBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String:String]
        
            else {
                return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        vc.visitorInfo = visitorDict
        vc.tabBarItem.image = UIImage(named:"tabbar_" + imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .highlighted)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 13)], for: UIControlState(rawValue:0))
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}
















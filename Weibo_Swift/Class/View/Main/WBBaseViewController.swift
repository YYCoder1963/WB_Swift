//
//  WBBaseViewController.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    var tableView : UITableView?
    var refreshControl : UIRefreshControl?
    var isPullUp = false
    var visitorInfo :[String:String]?
    
    
    /// 自定义导航条
    lazy var navigationBar  = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        if WBNetworkManager.shared.userLogon {
            loadData()
        }
        
    }

    @objc func login() {
     print("login")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil, userInfo: nil)
    }
    
    @objc func regist() {
        print("regist")
    }
    
    /// 重写title的didSet
    override var title: String?{
        didSet{
            navItem.title = title
        }
        
    }
    
    func loadData() {
        refreshControl?.endRefreshing()
    }
    
}

extension WBBaseViewController{
    
   fileprivate func setUpUI() {
        automaticallyAdjustsScrollViewInsets = false
        setUpNavigationBar()
        WBNetworkManager.shared.userLogon ? setUpTableView() : setUpVisitorView()
    }
    
    func setUpVisitorView()  {
        let visitorView = WBVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navigationBar)
        visitorView.infoDict = visitorInfo
        visitorView.registerBtn.addTarget(self, action: #selector(regist), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(regist))//UIBarButtonItem(title: "注册", target: self, action: #selector(regist), isBack: false)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))//UIBarButtonItem(title: "登录", target: self, action: #selector(login), isBack: false)
        
    }
    func setUpTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView?.addSubview(refreshControl!)
    }
    func setUpNavigationBar() {
        navigationBar.items = [navItem]
        view.addSubview(navigationBar)
        view.backgroundColor = UIColor.white
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        navigationBar.tintColor = UIColor.orange
    }

}


extension WBBaseViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = tableView.numberOfSections - 1
        let rowCount = tableView.numberOfRows(inSection: section)
        let row = indexPath.row
        if section < 0 || row < 0 {
            return
        }
        if row == rowCount - 1 {
            isPullUp = true
            loadData()
        }
        
    }
}















//
//  WBDemoViewController.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setUpTableView()
        title = "第 \(navigationController?.childViewControllers.count ?? 0) 个"
    }

   @objc func nextVC() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
   
}

extension WBDemoViewController{
    override func setUpTableView() {
        
        super.setUpTableView()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .plain, target: self, action: #selector(nextVC))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "next", fontSize: 16, target: self, action: #selector(nextVC),isBack:false)
    }
}

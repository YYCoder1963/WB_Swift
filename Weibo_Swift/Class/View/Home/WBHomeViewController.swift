//
//  WBHomeViewController.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

let cellId = "home"

class WBHomeViewController: WBBaseViewController {

    fileprivate lazy var viewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let urlStr = "https://api.weibo.com/2/statuses/public_timeline.json"
    let params = ["access_token":"2.00a3XzyBgSlaPDe85b4bcd2abkjwwC"]
    //
    

    override func loadData() {

        viewModel.loadStatus(isPullUp: isPullUp) { (isSuccess,hasMorePullUp) in
            self.refreshControl?.endRefreshing()
            self.isPullUp = false
            if hasMorePullUp {
               self.tableView?.reloadData()
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {

        }
        
    }
    @objc fileprivate func friends(){
        let vc = WBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension WBHomeViewController{
    
    override func setUpTableView() {
        super.setUpTableView()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 16, target: self, action: #selector(friends),isBack:false)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setUpNavTitle()
    }
    
    private func setUpNavTitle() {
        let button = WBTitleButton.init(title: "哇哈哈")
        button.addTarget(self, action: #selector(navTitleClicked(btn:)), for: .touchUpInside)
        navItem.titleView = button
    }
    
    @objc func navTitleClicked(btn:UIButton){
        btn.isSelected = !btn.isSelected
    }
}

extension WBHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.textLabel?.text = viewModel.statusList[indexPath.row].text
        return cell!
    }
}










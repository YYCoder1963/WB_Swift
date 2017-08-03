//
//  WBOAuthViewController.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
class WBOAuthViewController: UIViewController {

    lazy var webView = UIWebView()
    override func loadView() {
        view = webView
        webView.scrollView.isScrollEnabled = false
        webView.delegate = self
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill), isBack: false)
        title = "登录"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURL)"
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        
    }
    
    @objc func autoFill() {
        // 准备 js
        let js = "document.getElementById('userId').value = '13122359790'; " +
        "document.getElementById('passwd').value = 'q198908114418';"
        
        // 让 webview 执行 js
        webView.stringByEvaluatingJavaScript(from: js)
        
    }
    
    @objc func close() {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }

}



extension WBOAuthViewController:UIWebViewDelegate {

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("加载请求 -- \(String(describing: request.url?.absoluteString))")
        if (request.url?.absoluteString.hasPrefix(WBRedirectURL) == false){
            return true
        }
        print("加载请求 -- \(String(describing: request.url?.query))")
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            close()
            return false
        }
        
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        print("获取授权码:\(String(describing: code))")
        WBNetworkManager.shared.loadAccessToken(code: code)
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}



















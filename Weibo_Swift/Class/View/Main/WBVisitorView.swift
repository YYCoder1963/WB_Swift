//
//  WBVisitorView.swift
//  Weibo_Swift
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    public var infoDict :[String:String]?{
        didSet{
            guard let message = infoDict?["message"] ,let imageName = infoDict?["imageName"] else { return }
            tipsLabel.text = message
            if imageName == "" {
                startAnimation()
                return
            }
            
            iconView.image = UIImage(named: imageName)
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = Double.pi
        animation.repeatCount = MAXFLOAT
        animation.duration = 15
        animation.isRemovedOnCompletion = false
        iconView.layer.add(animation, forKey: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    lazy var maskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    lazy var houseIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    lazy var tipsLabel:UILabel = UILabel.cz_label(
        withText: "关注一些人，回这里看看有什么惊喜 关注一些人，回这里看看有什么惊喜",
        fontSize: 14,
        color: UIColor.darkGray)
    
    lazy var registerBtn:UIButton = UIButton.cz_textButton("注册",
             fontSize: 16,
             normalColor: UIColor.orange,
             highlightedColor: UIColor.black,
             backgroundImageName: "common_button_white_disable")
    
    lazy var loginBtn:UIButton = UIButton.cz_textButton("登录",
             fontSize: 16,
             normalColor: UIColor.orange,
             highlightedColor: UIColor.black,
             backgroundImageName: "common_button_white_disable")
    
}


extension WBVisitorView{
    func setUpUI() {
        self.backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipsLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        tipsLabel.textAlignment = .center
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: -60))
        
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: -10))
        
        addConstraint(NSLayoutConstraint(item: tipsLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipsLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: tipsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 236))
        
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .left, relatedBy: .equal, toItem: tipsLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .top, relatedBy: .equal, toItem: tipsLabel, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .left, relatedBy: .equal, toItem: registerBtn, attribute: .right, multiplier: 1.0, constant: 36))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .top, relatedBy: .equal, toItem: tipsLabel, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        let viewDict = ["maskIconView":maskIconView,
                        "registerBtn":registerBtn
                       ] as [String : Any]
        let metrics = ["space":-20]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: viewDict))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(space)-[registerBtn]", options: [], metrics: metrics, views: viewDict))
        
    }
}





















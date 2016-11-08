//
//  UserViewController.swift
//  Books
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController {
    
    let userSetView=UserSetView()
    
    let userView=UIView()
    
    var userAccording = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        let label=UILabel.createLabel("本地书架", textAlignment: .Center, font: 24, textColor: UIColor.whiteColor())
        label.frame=CGRectMake(0, 0, 100, 40)
        navigationItem.titleView=label
        let img=UIImage(named: "nav")
        navigationController?.navigationBar.setBackgroundImage(img, forBarMetrics: .Default)
        addNavBtn("left", text: nil, action: #selector(leftBtnClick), isLeft: true)
        addNavBtn(nil, text: "书城", action: #selector(rightBtnClick), isLeft: false)
        view.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        
        self.view.addSubview(userView)
        userView.backgroundColor = UIColor.whiteColor()
        userView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
        
        
        self.view.addSubview(userSetView)
        
    }
    func leftBtnClick(){
        if userAccording == true {
            UIView.animateWithDuration(1) {
                self.navigationController?.navigationBar.frame.origin.x += KScreenW/6*5
                self.userView.frame.origin.x += KScreenW/6*5
                self.userSetView.frame.origin.x += KScreenW/6*5
            }
            userAccording = false
        }else{
            UIView.animateWithDuration(1) {
                self.navigationController?.navigationBar.frame.origin.x -= KScreenW/6*5
                self.userView.frame.origin.x -= KScreenW/6*5
                self.userSetView.frame.origin.x -= KScreenW/6*5
            }
            userAccording = true
        }
    }
    
    func rightBtnClick(){
        let vc = MainTabBarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}




//
//  UserViewController.swift
//  Books
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

public typealias lookBookJumpClosure = (String -> Void)

class UserViewController: BaseViewController {
    
    var lookBook : lookBookJumpClosure?
    
    let userSetView=UserSetView()
    
    let userView=UserView()
    
    var userAccording = true
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //获取数据库里面存了包含bookName的数据
        let mo = DataBase.shareDataBase.findNameCount()
        userView.model = mo
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)//必须调用父类的方法
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(docPath!)

        automaticallyAdjustsScrollViewInsets = false
        //创建导航
        creatrNav()
        
//        let fm = NSFileManager.defaultManager()
//        let array = try! fm.contentsOfDirectoryAtPath(docPath!)
        
        view.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        
        self.view.addSubview(userView)
        
        userView.lookBook = {
            bookName in
            let vc = LookBookViewController()
            vc.bookName = bookName
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        userView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.view.addSubview(userSetView)
        
        
    }
    func creatrNav(){
        let label=UILabel.createLabel("本地书架", textAlignment: .Center, font: 24, textColor: UIColor.whiteColor())
        label.frame=CGRectMake(0, 0, 100, 40)
        navigationItem.titleView=label
        let img=UIImage(named: "nav")
        navigationController?.navigationBar.setBackgroundImage(img, forBarMetrics: .Default)
        addNavBtn("left", text: nil, action: #selector(leftBtnClick), isLeft: true)
        addNavBtn(nil, text: "书城", action: #selector(rightBtnClick), isLeft: false)
    }
    func leftBtnClick(){
        if userAccording == true {
            UIView.animateWithDuration(0.5) {
                self.navigationController?.navigationBar.frame.origin.x += KScreenW/6*5
                self.userView.frame.origin.x += KScreenW/6*5
                self.userSetView.frame.origin.x += KScreenW/6*5
            }
            userView.userInteractionEnabled = false
            userAccording = false
        }else{
            UIView.animateWithDuration(0.5) {
                self.navigationController?.navigationBar.frame.origin.x -= KScreenW/6*5
                self.userView.frame.origin.x -= KScreenW/6*5
                self.userSetView.frame.origin.x -= KScreenW/6*5
            }
            userView.userInteractionEnabled = true
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

extension UserViewController {
    
}




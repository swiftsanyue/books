//
//  UserViewController.swift
//  Books
//
//  Created by ZL on 16/11/3.
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
        //单列，NSUserDefaults用来操作app中的一个plist文件，可以用来存储一些基本数据类型，比如NSNunber、字符串、数组、字典、bool、NSData(二进制)、NSData(时间)，如果数字或者字典的元素不是基本数据类型，那么此数组或者字典不能使用NSUserDefaults存
        let userDefault = NSUserDefaults.standardUserDefaults()
        let fontSize=userDefault.objectForKey("fontSize")
        
        if fontSize == nil {
            //字典方法，有就修改，没有就删除
            userDefault.setObject("20", forKey: "fontSize")
            userDefault.setObject("0", forKey: "lookBookCocol")
            //让NSUserDefaults中的数据与plost文件中的数据同步
            userDefault.synchronize()
        }
        
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)//必须调用父类的方法
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        
        userView.deleteC = {
            [weak self]
            
            dele in
            if dele == "开始删除" {
                self!.addNavBtn(nil, text: "完成", action: #selector(self!.completeClick), isLeft: false)
            }else {
                let fileManager = NSFileManager.defaultManager()
                if fileManager.fileExistsAtPath(docPath!+"/"+dele) {
                    try! fileManager.removeItemAtPath(docPath!+"/"+dele)
                }
                DataBase.shareDataBase.deleteWith(dele)
                let mo = DataBase.shareDataBase.findNameCount()
                self!.userView.model = mo
            }
        }
        
        userView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
//        self.view.addSubview(userSetView)
        
        
    }
    
    func completeClick(){
        userView.colletionView.reloadData()
        userView.bool = false
        addNavBtn(nil, text: "书城", action: #selector(rightBtnClick), isLeft: false)
    }
    
    func creatrNav(){
        let label=UILabel.createLabel("本地书架", textAlignment: .Center, font: 24, textColor: UIColor.whiteColor())
        label.frame=CGRectMake(0, 0, 100, 40)
        navigationItem.titleView=label
        let img=UIImage(named: "nav")
        navigationController?.navigationBar.setBackgroundImage(img, forBarMetrics: .Default)
//        addNavBtn("left", text: nil, action: #selector(leftBtnClick), isLeft: true)
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
//        self.view.window?.rootViewController = vc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}

extension UserViewController {
    
}




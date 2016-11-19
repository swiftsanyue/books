//
//  MainTabBarViewController.swift
//  Books
//
//  Created by ZL on 16/10/28.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var label = UILabel.createLabel("精选", textAlignment: .Center, font: 18, textColor: UIColor.whiteColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.frame = CGRectMake(0, 0, 100, 40)
        navigationItem.titleView=label
        addNavBtn("icon_nav_back", text: nil, action: #selector(leftBtnCk), isLeft: true)
        addNavBtn("icon_search_white", text: nil, action: #selector(rightBtnCk), isLeft: false)

        
        
        //创建视图控制器
        createViewControllers()
        
        // Do any additional setup after loading the view.
    }
    
    //创建视图控制器
    func createViewControllers(){
        //视图控制器名字的数组
        var nameArray = ["SelectedController","ClassifyController","RankingController","FoundController"]
        
        //图片的名字
        var images = ["tab_feature","tab_mall","tab_shelf","Found"]
        //标题名字
        var titles = ["精选","分类","排行","发现"]
        
        //视图控制器对象的数组
        var ctrlArray:[UIViewController] = []
        for i in 0..<nameArray.count {
            //使用类名创建类的对象
            let ctrl = NSClassFromString("Books."+nameArray[i]) as! BaseViewController.Type
            let vc = ctrl.init()
            
            //设置文字和图片
            vc.tabBarItem.title = titles[i]
            vc.tabBarItem.image = UIImage(named: images[i]) 
            vc.tabBarItem.tag=100+i
            ctrlArray.append(vc)
        }

        view.tintColor=UIColor(red: 50/255, green: 170/255, blue: 137/255, alpha: 1.0)
        
        viewControllers = ctrlArray
        
    }
    func leftBtnCk(){
        navigationController?.popViewControllerAnimated(true)
    }
    func rightBtnCk(){
        
    }
    //系统TabBar被选中时调用的方法
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch item.tag {
        case 100:
            label.text="精选"
        case 101:
            label.text="分类"
        case 102:
            label.text="排行"
        case 103:
            label.text="发现"
        default:
            return
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

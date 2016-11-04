//
//  BaseViewController.swift
//  ZLDuanzi
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 zl. All rights reserved.
//

/*
 视图控制器的公共父类
 用来封装一些共有的代码
 */

import UIKit

class BaseViewController: UIViewController {
    
    //导航上面添加按钮
    func adNavCntrBtn(imageName:String,target:AnyObject,action:Selector,isLeft:Bool){
        let btn = UIButton.createBtn(nil, bgImageName: imageName, highlightImageName: nil, selectImageName: nil, target: target, action: action)
        btn.frame = CGRectMake(0, 0, 28, 42)
        let barBtn = UIBarButtonItem(customView: btn)
        if isLeft {
            //左边按钮
            navigationItem.leftBarButtonItem = barBtn
        }else{
            //右边按钮
            navigationItem.rightBarButtonItem = barBtn
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.whiteColor()

    }
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

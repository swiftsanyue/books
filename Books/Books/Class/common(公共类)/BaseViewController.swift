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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景颜色
        view.backgroundColor=UIColor.whiteColor()

        // Do any additional setup after loading the view.
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

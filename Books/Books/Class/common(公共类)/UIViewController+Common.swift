//
//  UIViewController+Common.swift
//  Books
//
//  Created by ZL on 16/10/28.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

extension UIViewController {
   
    //设置导航条左右按钮
    func addNavBtn(image: String?=nil,text: String?=nil,action:Selector,isLeft:Bool){
        let btn = UIButton()
        if image != nil && text != nil {
            btn.frame = CGRectMake(0,0,60,40)
        }else{
            btn.frame = CGRect(x: 0, y: 0, width: 40, height:40)
        }
        if image != nil {
            btn.setImage(UIImage(named: image!), forState: .Normal)
            btn.setImage(UIImage(named: image!), forState: .Highlighted)
        }
        if text != nil {
            btn.setTitle(text, forState: .Normal)
            btn.setTitle(text, forState: .Highlighted)
        }
        //自动适应
        btn.contentMode = .ScaleAspectFill

        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        
        let barBtn=UIBarButtonItem(customView: btn)
        if isLeft {
            //左边按钮
            navigationItem.leftBarButtonItem = barBtn
        }else{
            //右边按钮
            navigationItem.rightBarButtonItem = barBtn
        }
    }
}





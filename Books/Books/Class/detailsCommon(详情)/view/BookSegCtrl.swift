//
//  BookSegCtrl.swift
//  Books
//
//  Created by qianfeng on 16/11/17.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

protocol BookSegCtrlDelegate:NSObjectProtocol {
    
    //点击事件
    func segCtrl(segCtrl: BookSegCtrl,didClickBtnAtIndex index: Int)
    
}

class BookSegCtrl: UIView {
    
    //代理属性
    weak var delegate: BookSegCtrlDelegate?
    
    //重新实现初始化方法
    init(frame: CGRect,titleArray:Array<String>) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        //创建按钮
        if titleArray.count > 0{
            createBtns(titleArray)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBtns(titleArray:Array<String>){
        
        //按钮宽度
        let w = (bounds.size.width-40)/CGFloat(titleArray.count)
        
        for i in 0..<titleArray.count {
            let label=UILabel(frame: CGRectMake(20+CGFloat(i)*w,15,w,34))
            label.text = titleArray[i]
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(24)
            if i == 0 {
                label.textColor = UIColor.whiteColor()
                label.backgroundColor = UIColor.greenColor()
            }else {
                label.textColor = UIColor.greenColor()
                label.backgroundColor = UIColor.whiteColor()
            }
//            label.layer.cornerRadius = 5
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.greenColor().CGColor
            label.userInteractionEnabled = true
            label.tag = 600+i
            let g = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
            label.addGestureRecognizer(g)
            addSubview(label)
        }
        
    }
    
    func tapClick(g:UIGestureRecognizer){
        print(g.view?.tag)
    }

}

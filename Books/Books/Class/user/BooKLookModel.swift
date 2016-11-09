//
//  BooKLookModel.swift
//  Books
//
//  Created by qianfeng on 16/11/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class BooKLookModel: NSObject {
    
    var daxiao : String?
    var fengmian : String?
    var fenlei : String?
    var jianjie : String?
    var mingcheng : String?
    var xiazailiang : String?
    var zhangjie : Array<BookChapterModel>?
    var zuozhe : String?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "zhangjie" {
            var dataArray:[BookChapterModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=BookChapterModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            zhangjie = dataArray
        }
    }
}

class BookChapterModel: NSObject {
    var biaoti : String?
    var lujing : String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}






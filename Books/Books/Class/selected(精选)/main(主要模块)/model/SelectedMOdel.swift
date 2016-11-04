//
//  SelectedMOdel.swift
//  Books
//
//  Created by qianfeng on 16/10/29.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SwiftyJSON

func jsonParse(json: JSON,str:String)->[bookModel]{
    var tmpJx = Array<bookModel>()
    for (_, subjson): (String, JSON) in json[str] {
        let wModel = bookModel.parseModel(subjson)
        tmpJx.append(wModel)
    }
    return tmpJx
}


class SelectedModel: NSObject {
    var lhw_jx_0:[bookModel]?
    var lhw_jx_1:[bookModel]?
    var lhw_jx_2:[bookModel]?
    var lhw_jx_3:[bookModel]?
    var lhw_jx_4:[bookModel]?
    var lhw_jx_5:[bookModel]?
    
    //处理key的不正常状态是调用
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "lhw_jx_0" {
            var dataArray:[bookModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=bookModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            lhw_jx_0 = dataArray
        }
        if key == "lhw_jx_1" {
            var dataArray:[bookModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=bookModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            lhw_jx_1 = dataArray
        }
        if key == "lhw_jx_2" {
            var dataArray:[bookModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=bookModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            lhw_jx_2 = dataArray
        }
        if key == "lhw_jx_3" {
            var dataArray:[bookModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=bookModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            lhw_jx_3 = dataArray
        }
        if key == "lhw_jx_4" {
            var dataArray:[bookModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=bookModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            lhw_jx_4 = dataArray
        }
        if key == "lhw_jx_5" {
            var dataArray:[bookModel]=[]
            for dic in value as! [[String:AnyObject]] {
                let model=bookModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            lhw_jx_5 = dataArray
        }
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func parseData(data: NSData) -> SelectedModel {
        let json = JSON(data: data)
        let model = SelectedModel()
        model.lhw_jx_0 = jsonParse(json, str: "lhw_jx_0")
        model.lhw_jx_1 = jsonParse(json, str: "lhw_jx_1")
        model.lhw_jx_2 = jsonParse(json, str: "lhw_jx_2")
        model.lhw_jx_3 = jsonParse(json, str: "lhw_jx_3")
        model.lhw_jx_4 = jsonParse(json, str: "lhw_jx_4")
        model.lhw_jx_5 = jsonParse(json, str: "lhw_jx_5")
        return model
    }
}



class bookModel: NSObject {
    var daxiao : String?
    var fengmian : String?
    var jianjie : String?
    var mingcheng : String?
    var xiazailiang : String?
    var zuozhe : String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //解析
    class func parseModel(json: JSON) -> bookModel {
        
        let model = bookModel()
        model.daxiao = json["daxiao"].string
        model.fengmian = json["fengmian"].string
        model.jianjie = json["jianjie"].string
        model.mingcheng = json["mingcheng"].string
        model.xiazailiang = json["xiazailiang"].string
        model.zuozhe = json["zuozhe"].string
        return model
    }
}

//
//  SelectedController.swift
//  Books
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

public typealias SelectedJumpClosure = (AnyObject -> Void)

class SelectedController: BaseViewController {
    
    //闭包
    var jumpClosure:SelectedJumpClosure?
    
    var dataArray:[bookModel]=[]
    
    var dict:[String:AnyObject]=[:]
    
    
    
//    var lock:NSLock=NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        downloaderSelectedData()
    }
    
    //下载首页的数据
    func downloaderSelectedData(){
        //下载初始数据
        var sum = 0
        for i in 0..<currentUrls.count{
            
            
            Alamofire.request(.GET, urls[i]).responseJSON {
                (response) in
                
                
                if response.result.error == nil{
                    let dics=response.result.value as! [String:AnyObject]
                    for (key,value) in dics {
                        //将解析数据添加进字典
                        self.dict.updateValue(value, forKey: key)  
                    }
                    sum += 1
                }
                if sum == currentUrls.count{
//                    let str = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
//                    print(str)
                    self.dataArray.removeAll()
                    //系统解析的方法
//                    let model=SelectedModel()
//                    for (key,value) in self.dict {
//                        model.setValue(value, forKey: key)
//                    }
                    
                    for i in 0..<currentUrls.count{
                        let appArray=self.dict[currentUrls[i]] as! [[String:AnyObject]]
                        for dic in appArray{
                            let wmodel=bookModel()
                            wmodel.setValuesForKeysWithDictionary(dic)
                            self.dataArray.append(wmodel)
                        }
                    }
                    let selectedView = SelectedView(frame: CGRectZero)
                    self.view.addSubview(selectedView)
                    selectedView.models = self.dataArray
                    //约束
                    selectedView.snp_makeConstraints(closure: { (make) in
                        make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 49, 0))
                    })
                    selectedView.jumpClosure = {
                        jump in
                        if ((jump as? String) != nil) {
                        //更多书籍视图
                        let vc = MoreBookViewController()
                        if jump as? String == "精品书单"{
                            vc.urlJson = currentUrls[0]
                        }else if jump as? String == "热门书籍" {
                            vc.urlJson = currentUrls[1]
                        }else if jump as? String == "最新完结" {
                            vc.urlJson = currentUrls[2]
                        }else if jump as? String == "男生爱读" {
                            vc.urlJson = currentUrls[3]
                        }else if jump as? String == "女生爱读" {
                            vc.urlJson = currentUrls[4]
                        }else if jump as? String == "同人专区" {
                            vc.urlJson = currentUrls[5]
                        }
                        //修改导航
                        vc.createNav("精选书单", backTxte: "精选")
                        self.navigationController?.pushViewController(vc, animated: true)
                        }
                        if let model = jump as? bookModel {
                            let vc = AllInformationViewCtrl()
                            vc.models = model
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




//
//  ClassifyController.swift
//  Books
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

public typealias ClassJumpClosure = (AnyObject,Int) -> (Void)

class ClassifyController: BaseViewController {
    
    //拿到数据
    var dataArray:[ClassModel]=[]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //从class.json里面读取数据
        let path = NSBundle.mainBundle().pathForResource("class", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        do {
            let dics = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [[String:AnyObject]]
            for dic in dics {
                let model=ClassModel()
                model.setValuesForKeysWithDictionary(dic)
                dataArray.append(model)
            }
            
                    }catch (let error){
            print(error)
        }

        let classView = ClassView(frame: CGRectZero)
        self.view.addSubview(classView)
        classView.dataArray = dataArray
        
        //点击事件
        classView.classJump = {
            [weak self]
            (jump,page) in
            let vc = MoreBookViewController()
            vc.urlJson = jump as? String
            vc.createNav(self!.dataArray[page].group!, backTxte: "分类")
            self!.navigationController?.pushViewController(vc, animated: true)
        }
        
        //约束
        classView.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 49, 0))
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

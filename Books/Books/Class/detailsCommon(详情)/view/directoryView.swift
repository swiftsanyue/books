//
//  DirectoryView.swift
//  Books
//
//  Created by ZL on 16/11/16.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class DirectoryView: UIView {

    //闭包
    var JumClosure:lookJumClosure?
    
    var chapter:Int?{
        didSet{
             tbView?.reloadData()
        }
    }
    
    //数据
    var model:[BookChapterModel]?{
        didSet {
            //set 方法调用之后会调用这里的方法
            tbView?.reloadData()
        }
    }
 
    //表格
    private var tbView:UITableView?
    
    //重新实现初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建表格视图
        tbView = UITableView(frame: CGRectZero,style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource = self
        addSubview(tbView!)
        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DirectoryView:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if model?.count > 1 {
            row+=(model?.count)!
        }
        return row
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell=tableView.dequeueReusableCellWithIdentifier("cell")
        if cell==nil{
            cell=UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text=model![indexPath.row].biaoti
        if indexPath.row == chapter {
            cell?.textLabel?.textColor = UIColor.greenColor()
        }else {
            cell?.textLabel?.textColor = UIColor.blackColor()
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if JumClosure != nil {
            JumClosure!(indexPath.row)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    
}





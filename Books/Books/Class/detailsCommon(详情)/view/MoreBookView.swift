//
//  MoreBookView.swift
//  Books
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class MoreBookView: UIView,UpDownTableView {

    //闭包
    var jumpClosure:SelectedJumpClosure?
    
    //数据
    var dataArray:[bookModel]?{
        didSet {
            //set 方法调用之后会调用这里的方法
            tbView?.reloadData()
        }
    }
    //表格
    var tbView:UITableView?
    
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

//MARK:UITableView代理
extension MoreBookView{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        
        if dataArray?.count != nil {
        row+=(dataArray?.count)!
        }
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 140
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = MoreBookCell.createMoreCellFor(tableView, atIndexPath: indexPath, model: dataArray![indexPath.row])
        
        //点击事件的响应代码
//        cell.jumpClosure = jumpClosure
        cell.selectionStyle = .None

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if jumpClosure != nil && dataArray?[indexPath.row] != nil {
            jumpClosure!(dataArray![indexPath.row])
        }
        
//        设置反选
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

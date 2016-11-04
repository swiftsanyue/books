//
//  AllInformationView.swift
//  Books
//
//  Created by qianfeng on 16/11/2.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class AllInformationView: UIView {

    //闭包
    var jumpClosure:SelectedJumpClosure?
    
    var inforCell:AllInformationCell?
    
    //数据
    var model:bookModel?{
        didSet {
//            set 方法调用之后会调用这里的方法
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
        tbView?.showsVerticalScrollIndicator = false
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
extension AllInformationView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if inforCell != nil && inforCell!.heightForCell() > KScreenH-64-49{
            return inforCell!.heightForCell()
        }
        
        return KScreenH-64-49
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellId = "CellId"
        inforCell = tableView.dequeueReusableCellWithIdentifier(cellId) as? AllInformationCell
        if nil == inforCell {
            inforCell = AllInformationCell(style: .Default, reuseIdentifier: cellId)
        }
        inforCell?.model = model
        inforCell!.jumpClosure = jumpClosure
        inforCell?.selectionStyle = .None
        return inforCell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        inforCell?.userInteractionEnabled = false
        //设置反选
//        tableView.userInteractionEnabled = false
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}












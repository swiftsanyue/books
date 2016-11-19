//
//  BookMarksView.swift
//  Books
//
//  Created by ZL on 16/11/18.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class BookMarksView: UIView {
    
    //闭包
    var JumClosure:lookJumClosure?

    var bookMarks:[BeautyModel]?{
        didSet{
            tbView?.reloadData()
        }
    }
    //表格
    private var tbView:UITableView?
    
    var deleteArray:[NSIndexPath]=[]
    
    //重新实现初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建表格视图
        tbView = UITableView(frame: CGRectZero,style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource = self
        
        tbView!.setEditing(tbView!.editing, animated: true)
        
        
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

extension BookMarksView:UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if bookMarks?.count > 0 {
            row+=(bookMarks?.count)!
        }
        return row
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return KScreenH/4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "CellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? BookMarksCell
        if nil == cell {
            cell = BookMarksCell(style: .Default, reuseIdentifier: cellId)
            
        }
        cell?.model = bookMarks![indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if JumClosure != nil {
            JumClosure!(bookMarks![indexPath.row])
            
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    //删除的样式
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return .Delete
    }
    //删除的时候的文字
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    /*编辑indexPath位置的cell时候调用的方法
     参一：让代理调用方法的tableView
     参二：当前cell编辑的模式
     参三：被编辑cell的位置
     */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            
        BookMarksDataBase.shareDataBase.deleteWith(bookMarks![indexPath.row].bookMarks!)
            
        bookMarks?.removeAtIndex(indexPath.row)

            
        }
    }
}

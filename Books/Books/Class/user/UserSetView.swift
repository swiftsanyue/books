//
//  UserSetView.swift
//  Books
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class UserSetView: UIView {
    
    //表格
    private var tbView:UITableView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: -KScreenW/6*5, y: 0-64, width: KScreenW/6*5, height: KScreenH)
        let label = UILabel()
        label.text = "设  置"
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(24)
        addSubview(label)
        
        self.backgroundColor=UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        
        label.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        
        //创建表格视图
        tbView = UITableView(frame: CGRectZero,style: .Plain)
        tbView?.delegate=self
        tbView?.dataSource = self
        tbView?.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        tbView?.showsVerticalScrollIndicator = false
        //设置成为没有分割线
        tbView!.separatorStyle = .None
        addSubview(tbView!)
        
        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        })
        tbView!.registerNib(UINib(nibName: "UserSetCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:UITableView代理
extension UserSetView:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return KScreenH
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserSetCell
        

        
//        cell.jumpClosure = jumpClosure
        cell.selectionStyle = .None
        return cell
    }
    
    
//    //设置header样式
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        
//        
//        return nil
//    }
//    //设置header的高度
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return 0
//    }
//    //去掉UITableView的粘滞性
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let h : CGFloat = 54
//        if scrollView.contentOffset.y >= h {
//            scrollView.contentInset = UIEdgeInsetsMake(-h, 0, 0, 0)
//        }else if scrollView.contentOffset.y > 0 {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
//        }
//    }
}




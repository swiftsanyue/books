//
//  SelectedView.swift
//  Books
//
//  Created by ZL on 16/10/29.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SelectedView: UIView {
    
    //闭包
    var jumpClosure:SelectedJumpClosure?

    //数据
    var models:Array<bookModel>?{
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
        tbView?.showsVerticalScrollIndicator = false
        addSubview(tbView!)
        
        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })
        
//        let aiv=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
//        aiv.frame=CGRect(x: 100, y: 100, width: 200, height: 200)
//        aiv.startAnimating()
//        addSubview(aiv)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:UITableView代理
extension SelectedView:UITableViewDelegate,UITableViewDataSource{
    //组数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var section = 0
        if models?.count > 0{
            section += (models?.count)!/10
        }
        return section
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let range = NSMakeRange(indexPath.section*10,6)
        let array = NSArray(array: models!).subarrayWithRange(range) as! Array<bookModel>
        let cell = SelectedCell.createBannerCellFor(tableView, atIndexPath: indexPath, dataArray: array)
        
        cell.jumpClosure = jumpClosure
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //设置反选
//        tableView.userInteractionEnabled = false
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    //设置header样式
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SelectedHeaderView(frame: CGRectMake(0,0,(tbView?.bounds.size.width)!,44))
        if section == 0 {
        headerView.text = "精品书单"
        }else if section == 1 {
            headerView.text = "热门书籍"
        }else if section == 2 {
            headerView.text = "最新完结"
        }else if section == 3 {
            headerView.text = "男生爱读"
        }else if section == 4 {
            headerView.text = "女生爱读"
        }else if section == 5 {
            headerView.text = "同人专区"
        }
        headerView.jumpClosure = jumpClosure
        return headerView
    }
    //设置header的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 34
    }
    //去掉UITableView的粘滞性
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h : CGFloat = 54
        if scrollView.contentOffset.y >= h {
            scrollView.contentInset = UIEdgeInsetsMake(-h, 0, 0, 0)
        }else if scrollView.contentOffset.y > 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
    }
    
}

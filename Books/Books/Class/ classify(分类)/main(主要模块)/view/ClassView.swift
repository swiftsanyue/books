//
//  ClassView.swift
//  Books
//
//  Created by ZL on 16/11/4.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

//全部的时候的接口


//["lhw_yq_1,"lhw_yq_2"] 下面的小按钮接口分别


class ClassView: UIView {
    
    let color=[UIColor.purpleColor(),UIColor.blueColor(),UIColor.orangeColor(),UIColor.cyanColor()]
    
    var classUrl = ["lhw_yq","lhw_wx","lhw_xh","lhw_ds","lhw_wy","lhw_kbly","lhw_jdmz","lhw_zttl"]
    
    //闭包
    var classJump:ClassJumpClosure?
    
    var dataArray:[ClassModel]?{
        didSet{
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
        //设置成为没有分割线
        tbView?.separatorStyle = .None
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

//MARK : UITableView代理
extension ClassView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if dataArray?.count > 0 {
            row += (dataArray?.count)!
        }
        
        return row
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var h:CGFloat = 0
        if dataArray![indexPath.row].list?.count > 0 {
            let height = dataArray![indexPath.row].list?.count
            h = ClassViewCell.heightForCell(height!)
        }
        
        return h+20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
//        let cell = ClassViewCell.createBannerCellFor(tableView, atIndexPath: indexPath, model: dataArray![indexPath.row])

//        //显示数据
//        cell?.model = dataArray![indexPath.row]
        
        let cellId = "CellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ClassViewCell
        if nil == cell {
            cell = ClassViewCell(style: .Default, reuseIdentifier: cellId)

        }
        let sum = Int(arc4random()%UInt32(color.count))
        cell?.cellColor = color[sum]
        cell!.model = dataArray![indexPath.row]
        
        cell!.classJump = {
            [weak self]
            (jump,page) in
            for i in 0..<self!.classUrl.count {
                if jump as! String == self!.dataArray![i].group! {
                    if page == 0 {
                    self!.classJump!(self!.classUrl[i],i)
                    }else {
                        self?.classJump!(self!.classUrl[i]+"_\(page)",0)
                    }
                }
            }
        }
        cell!.selectionStyle = .None
        
        return cell!
//        return UITableViewCell()
    }
}




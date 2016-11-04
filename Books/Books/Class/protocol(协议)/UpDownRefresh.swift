//
//  UpDownRefresh.swift
//  Books
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import MJRefresh

protocol UpDownTableView: NSObjectProtocol,UITableViewDelegate, UITableViewDataSource {
    func addRefresh(tableView:UITableView,header:(()->())?,footer:(()->())?)
    
}

extension UpDownTableView {
    func addRefresh(tableView:UITableView,header:(()->())?=nil,footer:(()->())?=nil){
        if header != nil {
            tableView.mj_header=MJRefreshNormalHeader(refreshingBlock: header)
        }
        if footer != nil {
            tableView.mj_footer=MJRefreshAutoGifFooter(refreshingBlock: footer)
        }
    }
}

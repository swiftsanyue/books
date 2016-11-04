//
//  UserSetCell.swift
//  Books
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class UserSetCell: UITableViewCell {
    
    @IBOutlet weak var dataSizeLabel: UILabel!
    @IBAction func noImageSwitch(sender: UISwitch) {
        
        print("1")
    }
    
    
    @IBAction func lastSwitch(sender: UISwitch) {
        
        print("2")
    }
    


    @IBAction func btnClick(sender: UIButton) {
        print("3")
   
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSizeLabel.text = "0.0M"
        
    }
    
    //创建cell的方法
    class func createUserSetCellFor(tableView:UITableView,atIndexPath indexpath:NSIndexPath) -> UserSetCell{
        var cell=tableView.dequeueReusableCellWithIdentifier("userCell") as? UserSetCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("userCell", owner: nil, options: nil).last as? UserSetCell
        }
        return cell!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

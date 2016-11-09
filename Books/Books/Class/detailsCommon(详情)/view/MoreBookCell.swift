//
//  MoreBookCell.swift
//  Books
//
//  Created by qianfeng on 16/11/1.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class MoreBookCell: UITableViewCell {
    
    //闭包
    var jumpClosure:SelectedJumpClosure?
    
    var model:bookModel?{
        didSet{
            //显示数据
            showData()
        }
    }
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var bookNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var moreLabel: UILabel!
    
    private func showData(){
        if model != nil {
            
//            //将数据中的中文和"/"转换成url可以识别的数据
//            let str = model?.fengmian!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
//            //%2F是"/"转换后，需要替换回去
//            let str1=str!.stringByReplacingOccurrencesOfString("%2F", withString: "/")
               //这个最好不用
            //let str1 = model?.fengmian?.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            
            //专门对网络数据进行操作的 Path关键字
            let str = model?.fengmian?.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
            
            let url = NSURL(string: "http://xianyougame.com/shucheng/"+str!)
            //请求图片，第二个参数是默认图片，在没有请求下来的时候会显示
            ImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "bookcover_placeholder"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            
            if model?.mingcheng != nil {
            bookNameLabel.text = model?.mingcheng
            }
            if model?.zuozhe != nil {
                nameLabel.text = model?.zuozhe
            }
            if model?.jianjie != nil {
                moreLabel.text = model?.jianjie
            }
        }
    }
    //创建cell的方法
    class func createMoreCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,model:bookModel?)->MoreBookCell{
        let cellId = "moreBookCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MoreBookCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("MoreBookCell", owner: nil, options: nil).last as? MoreBookCell
        }
        //显示数据
        cell?.model = model
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

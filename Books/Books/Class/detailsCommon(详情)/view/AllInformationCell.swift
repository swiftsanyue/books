//
//  AllInformationCell.swift
//  Books
//
//  Created by qianfeng on 16/11/2.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class AllInformationCell: UITableViewCell {
    
    //闭包
    var jumpClosure:SelectedJumpClosure?
    
    var viewLabel = UILabel()
    
    var informationLabel = UILabel()
    
    var model: bookModel? {
        didSet{
            if model != nil {
                showData()
            }
        }
    }
    func showData(){
        if model != nil {
        viewLabel = UILabel(frame: CGRectMake(0,0,KScreenW,160))
        viewLabel.backgroundColor = UIColor.grayColor()
        contentView.addSubview(viewLabel)
        //创建视图
        let tmpImageView = UIImageView()
        //将数据中的中文和"/"转换成url可以识别的数据
        let str = model!.fengmian!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        //%2F是"/"转换后，需要替换回去
        let str1=str!.stringByReplacingOccurrencesOfString("%2F", withString: "/")
        let url = NSURL(string: "http://xianyougame.com/shucheng/"+str1)
        tmpImageView.kf_setImageWithURL(url!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(tmpImageView)
        
        tmpImageView.snp_makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.bottom.equalTo(viewLabel.snp_bottom).offset(-10)
            make.width.equalTo(100)
        }
        let bookNameLabel=UILabel.createLabel(model!.mingcheng, textAlignment: .Left, font: 18, textColor: UIColor.blackColor())
        bookNameLabel.numberOfLines = 2
        contentView.addSubview(bookNameLabel)
        
        bookNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(tmpImageView.snp_right).offset(20)
            make.right.equalTo(-60)
            make.top.equalTo(30)
            make.height.equalTo(36)
        }
        
        let nameLabel = UILabel.createLabel(model!.zuozhe, textAlignment: .Left, font: 13, textColor: UIColor(white: 0.9, alpha: 1.0))
        contentView.addSubview(nameLabel)
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(bookNameLabel.snp_bottom).offset(20)
            make.left.equalTo(bookNameLabel)
            make.height.equalTo(20)
            make.right.equalTo(-20)
        }
        informationLabel=UILabel.createLabel("    "+model!.jianjie!, textAlignment: .Left, font: 15, textColor: UIColor.blackColor())
        informationLabel.textAlignment = .Natural
        informationLabel.numberOfLines = 0
        contentView.addSubview(informationLabel)
        
        informationLabel.snp_makeConstraints { (make) in
            make.top.equalTo(viewLabel.snp_bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.greaterThanOrEqualTo(20)
        }
        
        }
    }
    
    //创建cell的方法
    class func createCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,model:bookModel) -> AllInformationCell{
        //重用标志
        let cellId = "cellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? AllInformationCell
        if nil == cell {
            
            cell = NSBundle.mainBundle().loadNibNamed("cellId", owner: nil, options: nil).last as? AllInformationCell
        }
        //显示数据
        cell?.model = model
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func heightForCell()->(CGFloat){
        self.layoutIfNeeded()
        return  self.viewLabel.frame.size.height+self.informationLabel.frame.size.height+20
    }
}

//
//  BookMarksCell.swift
//  Books
//
//  Created by ZL on 16/11/18.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class BookMarksCell: UITableViewCell {
    
    var model:BeautyModel?{
        didSet{
            showData()
        }
    }
    
    var bookMarksLabel = UILabel()
    
    var chapterLabel = UILabel()
    
    var timeLabel = UILabel()
    

    func showData(){
        if model != nil {
            chapterLabel.text = "第"+(model?.chapter)!+"章"
            chapterLabel.textColor = UIColor.redColor()
            addSubview(chapterLabel)
            chapterLabel.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(10)
                make.top.equalTo(5)
                make.height.equalTo(21)
                make.width.lessThanOrEqualTo(KScreenW/2)
            })
            timeLabel.text = model?.addTime
            timeLabel.textColor = UIColor.redColor()
            addSubview(timeLabel)
            timeLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(5)
                make.right.equalTo(-50)
                make.height.equalTo(21)
                make.width.lessThanOrEqualTo(KScreenW/2)
            })
            bookMarksLabel.text = model?.bookMarks
            bookMarksLabel.numberOfLines = 3
            bookMarksLabel.font = UIFont.systemFontOfSize(20)
            addSubview(bookMarksLabel)
            bookMarksLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(31)
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.bottom.equalTo(-30)
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

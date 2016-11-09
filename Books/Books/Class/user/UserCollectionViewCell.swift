//
//  UserCollectionViewCell.swift
//  Books
//
//  Created by qianfeng on 16/11/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView?
    var nameLabel:UILabel?
    var path:String?{
        didSet{
            showData()
        }
    }
    func showData(){
        
        //注意:滚动视图系统默认添加了一些子视图，删除子视图时要考虑一下会不会影响这些子视图
        //删除滚动视图之前的子视图
        for sub in contentView.subviews {
            sub.removeFromSuperview()
        }
        
        if path != nil {
            imageView=UIImageView()
            imageView?.image = UIImage(contentsOfFile: docPath!+"/"+path!+"/cover.jpg")
            contentView.addSubview(imageView!)
            imageView?.snp_makeConstraints(closure: { (make) in
                make.top.right.left.equalTo(0)
                make.bottom.equalTo(-40)
            })
            
            nameLabel=UILabel.createLabel(path!, textAlignment: .Left, font: 14, textColor: nil)
            nameLabel?.numberOfLines = 2
            
            contentView.addSubview(nameLabel!)
            nameLabel?.snp_makeConstraints(closure: { (make) in
                make.left.bottom.right.equalTo(0)
                make.top.equalTo(imageView!.snp_bottom)
            })
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
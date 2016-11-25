//
//  UserCollectionViewCell.swift
//  Books
//
//  Created by ZL on 16/11/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

public typealias deleteClosure = (String -> Void)

class UserCollectionViewCell: UICollectionViewCell {
    
    var deleteImage:UIImageView?
    
    var bool = false
    
    var imageView:UIImageView?
    
    var nameLabel:UILabel?
    
    var deleteC:deleteClosure?
    
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
            
            let backView = UIView()
            backView.layer.cornerRadius = 5
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.grayColor().CGColor
            contentView.addSubview(backView)
            backView.snp_makeConstraints(closure: { (make) in
                make.top.right.left.equalToSuperview()
                make.bottom.equalTo(-35)
            })
            
            self.layoutIfNeeded()
            
            
            imageView=UIImageView()
            imageView?.image = UIImage(contentsOfFile: docPath!+"/"+path!+"/cover.jpg")
            contentView.addSubview(imageView!)
            imageView?.snp_makeConstraints(closure: { (make) in
                make.top.right.left.equalToSuperview().inset(5)
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
        //添加删除按钮
        if bool != false{
            deleteImage=UIImageView(image: UIImage(named: "btn_delete"))
            contentView.addSubview(deleteImage!)
            deleteImage!.snp_makeConstraints(closure: { [weak self]
                (make) in
                make.centerX.equalTo((self?.snp_left)!).offset(5)
                make.centerY.equalTo((self?.snp_top)!).offset(5)
                make.width.height.equalTo(32)
                })
            deleteImage?.userInteractionEnabled = true
            let g = UITapGestureRecognizer(target: self, action: #selector(deleteBook(_:)))
            deleteImage?.addGestureRecognizer(g)
        }
        
    }
    
    
    func deleteBook(g:UIGestureRecognizer) {
        if deleteC != nil {
            deleteC!(path!)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        print(NSDate().timeIntervalSince1970)
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy年MM月dd日HH点mm分ss秒SSS毫秒"
        // yy 的话是16年
        let strNowTime = timeFormatter.stringFromDate(date) as String
        print(strNowTime)//2016年11月18日11点21分46秒893毫秒
        */
    }
    
    func animSave(){
        //下面的需要自己设置关键位置,设置的位置数量每有限制
        let anim = CAKeyframeAnimation(keyPath: "position")
        //设置5个位置点
        let p1 = CGPointMake(0.0, 0.0)
        let p2 = CGPointMake(300, 0.0)
        let p3 = CGPointMake(0.0, 400)
        let p4 = CGPointMake(300, 400)
        let p5 = CGPointMake(150, 200)
        
        //赋值
        anim.values = [NSValue(CGPoint: p1),
                       NSValue(CGPoint: p2),
                       NSValue(CGPoint: p3),
                       NSValue(CGPoint: p4),
                       NSValue(CGPoint: p5)]
        
        //每个动作的时间百分比
        anim.keyTimes = [NSNumber(float: 0.0),
                         NSNumber(float: 0.4),
                         NSNumber(float: 0.6),
                         NSNumber(float: 0.8),
                         NSNumber(float: 1.0), ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

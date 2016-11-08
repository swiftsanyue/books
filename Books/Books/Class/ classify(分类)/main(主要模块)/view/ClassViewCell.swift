//
//  ClassVierCell.swift
//  Books
//
//  Created by qianfeng on 16/11/4.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit



class ClassViewCell: UITableViewCell {
    
    //闭包
    var classJump:ClassJumpClosure?
    
    //cell的颜色
    var cellColor:UIColor?
    
    //X间距
    class private var spaceX:CGFloat{
        return 20
    }
    
    //Y间距
    class private var spaceY:CGFloat{
        return 20
    }
    
    //列数
    class private var colCount:Int{
        return 4
    }
    
    //字体的高度
    class private var h:CGFloat{
        return 20
    }
    
    //宽度
    class private var w: CGFloat {
        return (KScreenW-spaceX*2-spaceX*CGFloat(colCount-1))/CGFloat(colCount)
    }
    
    
    var model:ClassModel?{
        didSet{
            showData()
        }
    }
    func showData(){
        
        //删除之前的子视图
        for subView in contentView.subviews {
            subView.removeFromSuperview()
        }
        
        if model != nil {
            
            let backView=UIView()
            backView.layer.cornerRadius = 20
            backView.layer.masksToBounds = true
            contentView.addSubview(backView)
            backView.snp_makeConstraints(closure: { (make) in
                make.top.left.equalTo(15)
                make.bottom.right.equalTo(-15)
            })
            let topLabel = UILabel()
            topLabel.backgroundColor = cellColor
            topLabel.alpha = 0.3
            backView.addSubview(topLabel)
            topLabel.snp_makeConstraints(closure: { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(30)
            })
            let bottomLabel = UILabel()
            bottomLabel.backgroundColor = cellColor
            bottomLabel.alpha = 0.2
            backView.addSubview(bottomLabel)
            bottomLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(topLabel.snp_bottom)
                make.left.right.bottom.equalToSuperview()
            })
            
            let groupLabel=UILabel.createLabel(model!.group, textAlignment: .Left, font: 18, textColor: cellColor)
            contentView.addSubview(groupLabel)
            
            groupLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalToSuperview().offset(20)
                make.left.equalToSuperview().offset(20)
                make.height.equalTo(ClassViewCell.h)
                make.width.equalTo(200)
            })
            
            
            let allLabel=UILabel.createLabel("全部>>", textAlignment: .Right, font: 13, textColor: cellColor)
            
            allLabel.userInteractionEnabled = true
            let G = UITapGestureRecognizer(target: self, action: #selector(allLabelClick))
            allLabel.addGestureRecognizer(G)
            
            contentView.addSubview(allLabel)
            
            allLabel.snp_makeConstraints(closure: { (make) in
                make.top.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.width.equalTo(80)
                make.height.equalTo(20)
            })
            
            for i in 0..<model!.list!.count {
                
                let label = UILabel.createLabel(model!.list![i], textAlignment: .Center, font: 17, textColor: cellColor)
                label.userInteractionEnabled = true
                label.tag = 200+i
                let g = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
                label.addGestureRecognizer(g)
                contentView.addSubview(label)
                
                label.snp_makeConstraints(closure: { (make) in
                    make.width.equalTo(ClassViewCell.w)
                    make.height.equalTo(ClassViewCell.h)
                    
                    //计算当前行和列
                    let row = CGFloat(i/ClassViewCell.colCount)
                    let col = CGFloat(i%ClassViewCell.colCount)
                    
                    make.top.equalTo(ClassViewCell.spaceY*2+ClassViewCell.h+(ClassViewCell.spaceY+ClassViewCell.h)*row)
                    make.left.equalTo(ClassViewCell.spaceX+(ClassViewCell.spaceX+ClassViewCell.w)*col)
                })
            }
        }
    }
    
    func tapLabel(g:UIGestureRecognizer){
        let index = (g.view?.tag)! - 199
        if classJump != nil && model?.list != nil {
            classJump!((model?.group)!,index)
        }
        
    }
    
    func allLabelClick(){
        if classJump != nil && model != nil {
            classJump!((model?.group)!,0)
        }
    }
    
    
    //计算高度
    class func heightForCell(num: Int)->CGFloat {
        
        var row = CGFloat(num/ClassViewCell.colCount+1)
        
        if CGFloat(num%ClassViewCell.colCount) > 0 {
            row += 1
        }
        
        return CGFloat(row)*(ClassViewCell.spaceY+ClassViewCell.h)
    }

}

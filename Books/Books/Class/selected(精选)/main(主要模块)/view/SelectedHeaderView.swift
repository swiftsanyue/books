//
//  SelectedHeaderView.swift
//  Books
//
//  Created by ZL on 16/10/29.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SelectedHeaderView: UIView {

    //点击事件
    var jumpClosure: SelectedJumpClosure?
    
    //左边组名称
    var text:String?{
        didSet{
            configText(text!)
        }
    }
    
    //数据
    var selectedModel: SelectedModel?{
        didSet{
            
        }
    }
    
    //图片
    private var imageView:UIImageView?
    
    //文字
    private var titleLabel: UILabel?
    
    //更多文字
    private var moreLabel: UILabel?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        //白色背景
        let bgView=UIView.createView()
        bgView.backgroundColor = UIColor.whiteColor()
        bgView.frame = CGRectMake(0, 0, bounds.size.width, 34)
        addSubview(bgView)
        
        
        moreLabel = UILabel.createLabel("更多>", textAlignment: .Right, font: 13, textColor: UIColor.grayColor())
        moreLabel?.userInteractionEnabled = true
        bgView.addSubview(moreLabel!)
        moreLabel?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(bgView)
            make.right.equalTo(bgView).offset(-15)
        })
        //点击事件
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        moreLabel!.addGestureRecognizer(g)
        
        //文字
        titleLabel = UILabel.createLabel(nil, textAlignment: .Left, font: 18,textColor: UIColor.blackColor())
        
        bgView.addSubview(titleLabel!)
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(bgView)
            make.left.equalTo(bgView).offset(30)
        })
        
        
    }
    func configText(text:String){
        titleLabel?.text = text
    }
    
    @objc private func tapAction(){
        if jumpClosure != nil && titleLabel?.text != nil{
            jumpClosure!((titleLabel?.text)!)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

//
//  BookSegCtrl.swift
//  Books
//
//  Created by ZL on 16/11/17.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

protocol BookSegCtrlDelegate:NSObjectProtocol {
    
    //点击事件
    func segCtrl(segCtrl: BookSegCtrl,didClickBtnAtIndex index: Int)
    
}

class BookSegCtrl: UIView {
    
    //代理属性
    weak var delegate: BookSegCtrlDelegate?
    
    //设置当前的序号
    var selectIndex: Int = 0 {
        didSet{
            if selectIndex != oldValue{
                //取消之前的选中状态
                let lastBtn = viewWithTag(600+oldValue)
                if lastBtn?.isKindOfClass(KTCSegBtn) == true {
                    let tmpBrn = lastBtn as! KTCSegBtn
                    tmpBrn.clicked = false
                }

                //选中当前点击的按钮
                let curBtn = viewWithTag(600+selectIndex)
                if lastBtn?.isKindOfClass(KTCSegBtn) == true {
                    let tmpBrn = curBtn as! KTCSegBtn
                    tmpBrn.clicked = true
                }
            }
        }
    }
    
    //重新实现初始化方法
    init(frame: CGRect,titleArray:Array<String>) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        //创建按钮
        if titleArray.count > 0{
            createBtns(titleArray)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBtns(titleArray:Array<String>){
        
        //按钮宽度
        let w = (bounds.size.width-40)/CGFloat(titleArray.count)
        
        for i in 0..<titleArray.count {
            let label=UILabel(frame: CGRectMake(20+CGFloat(i)*w,15,w,34))
            label.text = titleArray[i]
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.greenColor().CGColor
            //循环创建按钮
            let frame = CGRectMake(20+CGFloat(i)*w,15,w,34)
            let btn = KTCSegBtn(frame: frame)
            

            //默认选中第一个
            if i == 0 {
                btn.clicked = true
            }else{
                btn.clicked = false
            }
            
            btn.config(titleArray[i])
            
            //添加点击事件
            btn.tag = 600+i
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            
            addSubview(btn) 
        }
    }
    func clickBtn(btn:KTCSegBtn){
        let index = btn.tag-600
        //修改选中的UI
        selectIndex = index
        delegate?.segCtrl(self, didClickBtnAtIndex: index)
    }
}



//自定制按钮
class KTCSegBtn:UIControl {
    
    private var titleLabel: UILabel?
    
    //设置选中状态
    var clicked: Bool = false{
        didSet{
            if clicked == true{
                //选中
                titleLabel?.textColor = UIColor.whiteColor()
                titleLabel?.backgroundColor = UIColor.greenColor()
            }else{
                //取消选中
                titleLabel?.textColor = UIColor.blackColor()
                titleLabel?.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    //显示数据
    func config(title:String?){
        titleLabel?.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel.createLabel(nil, textAlignment: .Center, font: 24, textColor: nil)
        titleLabel?.frame = bounds
        
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




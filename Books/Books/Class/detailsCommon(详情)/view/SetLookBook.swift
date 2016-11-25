//
//  SetLookBook.swift
//  Books
//
//  Created by ZL on 16/11/21.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

protocol SetLookBookDelegate:NSObjectProtocol {
    
    //点击事件
    func bgCtrl(setLookBook: SetLookBook,didClickBtnAtIndex index: Int)
    
}


class SetLookBook: UIView {
    
    var jum : lookJumClosure?

    //代理属性
    weak var delegata : SetLookBookDelegate?
    
    var btnBack:UIButton?
    
    private lazy var startIndex:Int = {
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        let index = userDefault.objectForKey("lookBookCocol")?.integerValue
        
        return index!
    }()
    
    //设置当前的序号
    var selectIndex = 0 {
        
        didSet{
            
            if selectIndex != oldValue{
                //取消之前的选中状态
                let lastBtn = viewWithTag(666+oldValue)
                if lastBtn?.isKindOfClass(bgFontBtn) == true {
                    let tmpBrn = lastBtn as! bgFontBtn
                    tmpBrn.clicked = false
                }
                
                //选中当前点击的按钮
                let curBtn = viewWithTag(666+selectIndex)
                if lastBtn?.isKindOfClass(bgFontBtn) == true {
                    let tmpBrn = curBtn as! bgFontBtn
                    tmpBrn.clicked = true
                }
            }
        }
    }
    init(frame: CGRect,imageNames:[String]) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        //按钮左右边距
        let spacing:CGFloat = 20
        
        //按钮中间边距
        let margin:CGFloat = 30
        
        //按钮宽度
        let w = (KScreenW - spacing*2 - CGFloat(imageNames.count-1)*margin)/CGFloat(imageNames.count)
        
        
        
        for i in 0...1 {
            let label = UILabel(frame: CGRectMake(30+CGFloat(i)*((KScreenW-120)/2+60),10,(KScreenW-120)/2,40))
            if i == 0 {
                label.text = "A-"
            }else {
                label.text = "A+"
            }
            label.textColor = UIColor.greenColor()
            label.textAlignment = .Center
            label.layer.cornerRadius = 10
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.greenColor().CGColor
            label.font = UIFont.systemFontOfSize(30)
            label.tag = 100+i
            label.userInteractionEnabled = true
            let g = UITapGestureRecognizer(target: self, action: #selector(fontClick(_:)))
            label.addGestureRecognizer(g)
            addSubview(label)
            
        }
        
        for i in 0..<imageNames.count {
            
            let btn = bgFontBtn(frame: CGRectMake(spacing+CGFloat(i)*(margin+w),60,w,w))
            
            if i == startIndex {
                btn.clicked = true
            }else {
                btn.clicked = false
            }
            btn.cofig(imageNames[i])
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            
            btn.tag = 666+i
            addSubview(btn)
        }
        
         selectIndex = startIndex
        
    }
    func fontClick(g:UIGestureRecognizer){
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let fontSize=userDefault.objectForKey("fontSize")
        var aa = NSNumber(integer: (fontSize as! NSString).integerValue) as Int
        if g.view?.tag == 100 {
            
            aa -= 1
            userDefault.setObject("\(aa)", forKey: "fontSize")
            userDefault.synchronize()
            
        }else if g.view?.tag == 101 {
            aa += 1
            userDefault.setObject("\(aa)", forKey: "fontSize")
            userDefault.synchronize()
        }
        

        if jum != nil {
            jum!(1)
        }
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func clickBtn(btn:bgFontBtn){
        let index = btn.tag-666
        //修改选中的UI
        if index < 100 {
        selectIndex = index
        }
        delegata?.bgCtrl(self, didClickBtnAtIndex: index)
    }

}


//自定制按钮
class bgFontBtn:UIControl {
    
    private var bgImage: UIImageView?
    
    //设置选中状态
    var clicked: Bool = false{
        didSet{
            if clicked == true{
                //选中
                bgImage?.layer.borderWidth = 2
                bgImage?.layer.borderColor = UIColor.greenColor().CGColor
                
            }else{
                //取消选中
                bgImage?.layer.borderWidth = 0
            }
        }
    }
    
    func cofig(imageName:String?){
        bgImage?.image = UIImage(named: imageName!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgImage = UIImageView()
        bgImage?.frame = bounds
        bgImage!.layer.cornerRadius = frame.size.width/6
        bgImage!.layer.masksToBounds = true
        bgImage?.contentMode = .ScaleAspectFit
        addSubview(bgImage!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


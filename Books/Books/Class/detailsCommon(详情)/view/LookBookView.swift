//
//  LookBookView.swift
//  Books
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class LookBookView: UIView {
    
    var jumClosure:lookJumClosure?
    
    //滚动视图
    var scrollView:UIScrollView?
    
    //滚动视图上面的容器视图
    private var containerView:UIView? = nil
    
    //记录下滑动的时候初始位置
    private var startContentOffsetX = CGPoint.init(x: 0, y: 0)
    
    //记录上一个View位置
    private var lastView: UIView? = nil
    
    //记录位置的字符串
    private var recordString:NSString?
    
    //字体的大小
    var attr = [NSFontAttributeName:UIFont.systemFontOfSize(18)]
    
    //数据数据的存放
    var model:BooKLookModel? {
        didSet{
            showData()
        }
    }
    
    //记录更新的页面数
    var page = 0
    
    var jumChapter:Bool = false
    
    //章节页码
    var chapter:Int = 0 {
        didSet {
            
            if oldValue > chapter && page > 0  && oldValue > 0 {
                
                if jumClosure != nil {
                    jumClosure!(model!.zhangjie![chapter].biaoti!)
                }
                scrollView?.userInteractionEnabled = false
                page = 0
                showData()
                if jumChapter == false {
                    scrollView?.contentOffset.x = (CGFloat(page-1))*KScreenW
                }else {
                    scrollView?.contentOffset.x = 0
                }
                
            }else if oldValue == 0 && oldValue > chapter{
                popupWindow(1)
                chapter = 0
            }else if oldValue < chapter && page > 0 && chapter != (model?.zhangjie?.count)!{
                scrollView?.contentOffset.x = 0
                if jumClosure != nil {
                    jumClosure!(model!.zhangjie![chapter].biaoti!)
                }
                scrollView?.userInteractionEnabled = false
                page = 0
                showData()
            }else if chapter == (model?.zhangjie?.count)! {
                popupWindow(2)
                chapter-=1
            }
            jumChapter = false
        }
    }
    
    private func showData(){
        
        for subView in (scrollView?.subviews)! {
            subView.removeFromSuperview()
            lastView = nil
        }
        
        //拿到文件中的文字
        let path = docPath!+"/\(model!.mingcheng!)"+(model?.zhangjie![chapter].lujing!)!
        
        let data = NSData(contentsOfFile: path)
        
        //当前章节总的字符串
        recordString = NSString(data: data!,encoding: NSUTF8StringEncoding)
        
        //去除字符串首尾空格和换行
        let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        recordString = recordString!.stringByTrimmingCharactersInSet(whitespace)
        
        //1.创建一个容器视图,作为滚动视图的子视图
        containerView = UIView.createView()
        scrollView!.addSubview(containerView!)
        containerView!.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(scrollView!)
            //一定要设置高度
            make.height.equalTo(KScreenH)
        })
        while recordString != "" {
            paging()
            page+=1
        }
        //3.修改container的宽度
        containerView!.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(lastView!)
        })
        scrollView?.userInteractionEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        scrollView=UIScrollView(frame: CGRectMake(0,0,KScreenW,KScreenH))
        scrollView?.pagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        //        scrollView?.bounces = false
        
        addSubview(scrollView!)
        
    }
    //MARK: 分页
    func paging(){
        
        var strCoding:String?
        
        let length = Int((recordString as! String).characters.count)
        
        var range = NSRange(location: 0,length: length)
        
        while range.length>0 {
            
            let textH = recordString!.boundingRectWithSize(CGSize(width: KScreenW-40, height: 0), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.height
            
            if textH < KScreenH-40 {
                strCoding = recordString! as String
                recordString = ""
                break
            }
            
            if strCoding == nil && textH>KScreenH-40{
                range.length = Int(CGFloat(range.length)/(textH/(KScreenH-40)))
                strCoding = recordString?.substringWithRange(range)
                var h = strCoding!.boundingRectWithSize(CGSize(width: KScreenW-40, height: 0), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.height
                while h < KScreenH-40 {
                    range.length += 1
                    strCoding = recordString?.substringWithRange(range)
                    h = strCoding!.boundingRectWithSize(CGSize(width: KScreenW-40, height: 0), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.height
                }
            }
            strCoding = recordString?.substringWithRange(range)
            let h = strCoding!.boundingRectWithSize(CGSize(width: KScreenW-40, height: 0), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.height
            
            if h <= KScreenH-40 {
                strCoding = recordString?.substringWithRange(range)
                recordString = recordString!.substringFromIndex(range.length)
                break
            }else {
                range.length -= 1
            }
        }
        let interfaceView = UIView.createView()
        createBtn(interfaceView)
        containerView!.addSubview(interfaceView)
        interfaceView.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView!)
            make.width.equalTo(scrollView!)
            if lastView == nil {
                make.left.equalTo(containerView!)
            }else{
                make.left.equalTo((lastView?.snp_right)!)
            }
        })
        lastView = interfaceView
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFontOfSize(18)
        label.text = strCoding
        label.tag = 500+page
        interfaceView.addSubview(label)
        
        label.snp_makeConstraints(closure: { (make) in
            make.left.right.top.equalToSuperview().inset(20)
            make.height.lessThanOrEqualTo(KScreenH-40)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 左右中间点击效果
    func createBtn(view:UIView){
        for i in 0...2{
            let btn = UIButton(frame: CGRect(x: 0+CGFloat(i)*(KScreenW/3), y: 0, width: KScreenW/3, height: KScreenH))
            btn.tag = 300+i
            btn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: .TouchUpInside)
            view.addSubview(btn)
        }
    }
    func btnClick(btn:UIButton){
        if btn.tag == 300 {
            
            if (scrollView?.contentOffset.x)! == 0{
                chapter-=1
            }else {
                scrollView?.contentOffset.x -= KScreenW
            }
            
        }else if btn.tag == 301 {
            
            if jumClosure != nil {
//
                jumClosure!("显示上下界面")
            }
            
        }else if btn.tag == 302 {
            
            if (scrollView?.contentOffset.x)! == (containerView?.frame.size.width)! - KScreenW {
                chapter+=1
                scrollView?.contentOffset.x = 0
                
            }else {
                scrollView?.contentOffset.x += KScreenW
            }
        }
        if containerView?.frame.size.width != 0 {
            let sliderValue = (scrollView!.contentOffset.x) / (containerView!.frame.size.width-KScreenW)
            
            if jumClosure != nil {
                jumClosure!(sliderValue*100)
            }
            
        }
    }
    //MARK: 弹窗
    func popupWindow(id:Int){
        var label:UILabel?
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        if id == 1 {
            label!.text = "当前为第一章节"
        }else if id == 2 {
            label?.text = "已经是最后章节"
        }else if id == 3 {
            label?.text = "添加书签成功"
        }
        label?.center = center
        label?.textAlignment = .Center
        label?.layer.cornerRadius = 15
        label?.layer.masksToBounds = true
        label!.backgroundColor = UIColor.blackColor()
        label!.alpha = 0.6
        label?.textColor = UIColor.whiteColor()
        self.addSubview(label!)
        UIView.animateWithDuration(0.25, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            label?.layer.transform=CATransform3DMakeScale(1.2,1.2,1.2)
        }) { (b) in
            label?.removeFromSuperview()
        }
    }
}
//MARK:scrollView代理
extension LookBookView:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        if startContentOffsetX.x == -1{
            chapter -= 1
            startContentOffsetX.x = 0
        }else if startContentOffsetX.x == 1{
            chapter += 1
            startContentOffsetX.x = 0
        }
        if containerView?.frame.size.width != 0 {
            let sliderValue = (scrollView.contentOffset.x) / (containerView!.frame.size.width-KScreenW)
            if jumClosure != nil {
                jumClosure!(sliderValue*100)
            }
        }
    }
    //开始滑动的时候调用的方法
    func scrollViewDidScroll(scrollView: UIScrollView){
        if scrollView.contentOffset.x <= -10{
            if scrollView.userInteractionEnabled {
                startContentOffsetX.x = -1
            }
            
        }else if (scrollView.contentOffset.x) >= (containerView?.frame.size.width)! - KScreenW+10 && (containerView?.frame.size.width)! != 0{
            if scrollView.userInteractionEnabled{
                startContentOffsetX.x = 1
            }
        }
    }
}







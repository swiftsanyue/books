//
//  SetBookView.swift
//  Books
//
//  Created by ZL on 16/11/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SetBookView: UIView {
    
    var jumClosure:lookJumClosure?
    
    //滚动视图
    private var scrollView:UIScrollView?
    
    //当前的章节
    var chapter:Int?{
        didSet{
            if directoryView != nil {
                directoryView?.chapter = chapter!
            }
        }
    }
    
    //目录的视图
    var directoryView:DirectoryView?
    
    //书签的视图
    var bookmarksView:BookMarksView?
    
    //顶部的选择控件
    private var segCtrl: BookSegCtrl?
    
    var model:[BookChapterModel]?{
        didSet{
            if directoryView != nil {
                directoryView?.model = model
            }
        }
    }
    var bookName:String?{
        didSet{
            if BookMarksDataBase.shareDataBase.selectEntity(bookName!) != nil {
                let mo = BookMarksDataBase.shareDataBase.findNameCount(bookName!)
                var arr:[BeautyModel]=[]
                for mod in mo! {
                    let models = BeautyModel()
                    models.addTime = mod.addTime
                    models.bookMarks = mod.bookMarks
                    models.chapter = mod.chapter
                    models.booksName = mod.booksName
                    models.record = mod.record
                    arr.append(models)
                }
                if bookmarksView != nil {
                    bookmarksView?.bookMarks = arr
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView=UIScrollView(frame: CGRectMake(0,64,KScreenW/6*5,KScreenH-64))
        scrollView?.pagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        
        addSubview(scrollView!)
        
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView!)
            make.height.equalTo(scrollView!)
        }
        
        segCtrl = BookSegCtrl(frame: CGRectMake(0, 0, KScreenW/6*5, 64), titleArray: ["目录","书签"])
        segCtrl!.delegate = self
        self.addSubview(segCtrl!)
        
        directoryView=DirectoryView()
        containerView.addSubview(directoryView!)
        directoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalTo(containerView)
            make.width.equalTo(KScreenW/6*5)
        })
        
        
        bookmarksView=BookMarksView()
        
        containerView.addSubview(bookmarksView!)
        bookmarksView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.left.equalTo((directoryView?.snp_right)!)
            make.width.equalTo(KScreenW/6*5)
        })
        
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(bookmarksView!)
        }
        
        
        //目录的
        directoryView?.JumClosure = {
            [weak self]
            jum in
            self!.jumClosure!(jum)
        }
        //书签的
        bookmarksView?.JumClosure = {
            [weak self]
            jum in
            
            self!.jumClosure!(jum)
        }
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.blackColor()
        btn.alpha = 0.3
        btn.addTarget(self, action: #selector(backLookBook), forControlEvents: .TouchUpInside)
        addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(scrollView!.snp_right)
            make.width.equalTo(KScreenW/6*7)
        }
        
        
    }
    
    func backLookBook(){
        
        if jumClosure != nil {
            jumClosure!("继续看书")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: BookSegCtrl代理
extension SetBookView:BookSegCtrlDelegate{
    func segCtrl(segCtrl: BookSegCtrl, didClickBtnAtIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*KScreenW/6*5, 0), animated: true)
    }
}


extension SetBookView:UIScrollViewDelegate{
    //让滚动视图和标签同步
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/scrollView.bounds.width
        segCtrl?.selectIndex = Int(index)
    }
}




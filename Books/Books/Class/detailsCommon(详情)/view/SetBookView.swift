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
    var segCtrl: BookSegCtrl?
    
    var model:[BookChapterModel]?{
        didSet{
            if directoryView != nil {
                directoryView?.model = model
            }
        }
    }
    var bookName:String?{
        didSet{
            
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        segCtrl = BookSegCtrl(frame: CGRectMake(0, 0, KScreenW/6*5, 64), titleArray: ["目录","书签"])
        segCtrl!.delegate = self
        self.addSubview(segCtrl!)
        
        directoryView=DirectoryView()
        addSubview(directoryView!)
        directoryView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(64)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(KScreenW/6*5)
        })
        
        
        
        
        
        //目录的
        directoryView?.JumClosure = {
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
            make.left.equalTo(self.snp_left).offset(KScreenW/6*5)
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

        if index == 0 {
            directoryView?.hidden = false
            bookmarksView?.hidden = true
            
        }else if index == 1 {
            self.directoryView?.hidden = true
            bookmarksView=BookMarksView()
            
            addSubview(bookmarksView!)
            bookmarksView?.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(64)
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.width.equalTo(KScreenW/6*5)
            })
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
                //书签的
                bookmarksView?.JumClosure = {
                    [weak self]
                    jum in
                    
                    self!.jumClosure!(jum)
                }
            }
        }
    }
}






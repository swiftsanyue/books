//
//  LookBookViewController.swift
//  Books
//
//  Created by ZL on 16/11/9.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

public typealias lookJumClosure = (AnyObject -> Void)

class LookBookViewController: UIViewController {
    
    var bookName:String?
    
    //设置文字大小和书面背景的视图
    var setLookBook:SetLookBook?
    
    //书籍显示的视图
    private var lookBookView:LookBookView?
    
    //底部视图
    private var footSetView:UIView?
    
    //底部视图上面的滚动条
    private var slider:UISlider!
    
    //书签按钮
    private var btn:UIButton?
    
    //
    var model:BooKLookModel?
    
    //书籍设置的视图
    private var setBookView:SetLookBook?

    //左边的书籍目录书签视图
    var setView:SetBookView?
    
    //步进器上面的标签
    private var progressLabel:UILabel!
    
    var ctrlHidden:Bool = true {
        didSet{
        navigationController?.setNavigationBarHidden(ctrlHidden, animated: true)
            UIApplication.sharedApplication().statusBarHidden = ctrlHidden
            if UIApplication.sharedApplication().statusBarHidden {
                UIView.animateWithDuration(0.25){
                    self.footSetView?.frame.origin.y = KScreenH
                    self.lookBookView?.back(true)
                    
                }
            }else {
                UIView.animateWithDuration(0.25){
                    self.footSetView?.frame.origin.y = KScreenH/8*7
                    
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(ctrlHidden, animated: false)
        UIApplication.sharedApplication().statusBarHidden = ctrlHidden
    }
    //MARK:页面将要退出的时候
    override func viewWillDisappear(animated: Bool) {
        let models = BeautyModel()
        models.booksName = model?.mingcheng
        models.chapter = "\((lookBookView?.chapter)!)"
        
        let page=Int((lookBookView?.scrollView?.contentOffset.x)!/KScreenW)
        let tmpLabel=lookBookView?.viewWithTag(1000+page)
        if ((tmpLabel?.isKindOfClass(UILabel)) != nil){
            let label = tmpLabel as! UILabel
            let range=lookBookView?.allString?.rangeOfString(label.text!)
            models.record = "\(range!.location)"
            
        }
        
        DataBase.shareDataBase.upDateData(Model: models)
        
    }
    
    //MARK:添加标签的按钮
    func bookMarks(btn:UIButton){
        
        if btn.selected == false {
            btn.selected = true
            if model != nil {
                let models = BeautyModel()
                models.booksName = model!.mingcheng!
                let page=Int((lookBookView?.scrollView?.contentOffset.x)!/KScreenW)
                let tmpLabel=lookBookView?.viewWithTag(1000+page)
                if ((tmpLabel?.isKindOfClass(UILabel)) != nil){
                    let label = tmpLabel as! UILabel
                    models.bookMarks = label.text
                    let range=lookBookView?.allString?.rangeOfString(label.text!)
                    models.record = "\(range!.location)"
                }
                models.chapter = "\((lookBookView?.chapter)!+1)"
                BookMarksDataBase.shareDataBase.insertWithModel(models)
                lookBookView?.popupWindow(3)
            }
        }else {
            btn.selected = false
            if model != nil {
                let page=Int((lookBookView?.scrollView?.contentOffset.x)!/KScreenW)
                let tmpLabel=lookBookView?.viewWithTag(1000+page)
                let label = tmpLabel as! UILabel
                let range=lookBookView?.allString?.rangeOfString(label.text!)
                let array = BookMarksDataBase.shareDataBase.findNameCount(bookName!)
                for arr in array! {
                    let num = Int(NSNumber(integer: (arr.record! as NSString).integerValue))
                    if num >= (range?.location)! && num <= (range?.location)!+(range?.length)! {
                        BookMarksDataBase.shareDataBase.deleteWith(arr.record!)
                    }
                }
                lookBookView?.popupWindow(4)
            }
        }
    }
    //判断当前视图是否已经在书签里面有了
    func judgeBtn(){
        
        let page=Int((lookBookView?.scrollView?.contentOffset.x)!/KScreenW)
        
        let tmpLabel=lookBookView?.viewWithTag(1000+page)
        
            let label = tmpLabel as! UILabel
            let range=lookBookView?.allString?.rangeOfString(label.text!)
            let array = BookMarksDataBase.shareDataBase.findNameCount(bookName!)
        if array?.count > 0 {
            for arr in array! {
                let num = Int(NSNumber(integer: (arr.record! as NSString).integerValue))
                
                if num >= (range?.location)! && num <= (range?.location)!+(range?.length)! {
                    btn!.selected = true
                }else {
                    btn!.selected = false
                }
            }
        }else {
            btn?.selected = false
        }
    }
    //创建导航书签的按钮
    func navRightBtn(){
        btn=UIButton.createBtn(nil, bgImageName: "ReadingBookmarkUnAddButtonNormal", highlightImageName: nil, selectImageName: "ReadingBookmarkAddButtonNormal", target: self, action: #selector(bookMarks(_:)))
        btn!.frame = CGRect(x: 0, y: 0, width: 44, height:44)
        judgeBtn()
        
        let barBtn=UIBarButtonItem(customView: btn!)
        navigationItem.rightBarButtonItem = barBtn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        addNavBtn("WKBackButtonNormalForMyFav_Ios7_12x22_", action: #selector(backClick), isLeft: true)
        
        navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        

        //创建视图
        createView()
        //左侧滑动视图
        createSetView()
        //解析本地数据
        loadData()
        //底部设置视图
        setLookBookView()
        //设置文字大小和书面背景的视图
        createSetLookBookView()
        
        //滚动球的显示label
        createProgressLable()
        //系统自带隐藏导航功能，直接在视图上下滑动，或者点击导航
        //        navigationController?.hidesBarsOnSwipe = true
        navRightBtn()
        
    }
    //MARK:创建了阅读界面，处理返回值
    func createView(){
        lookBookView = LookBookView(frame: CGRectMake(0,0,KScreenW,KScreenH))
        self.view.addSubview(lookBookView!)
        
        lookBookView?.jumClosure = {
            [weak self]
            jum in
            
            if (jum as? String == "上下界面") {
                self!.ctrlHidden = !self!.ctrlHidden
                self!.navigationItem.title = self!.lookBookView?.model?.zhangjie![(self!.lookBookView?.chapter)!].biaoti
                self!.judgeBtn()
               
            }else if (jum as? String != nil) {
                self!.navigationItem.title = jum as? String
            }
            
            if jum as? CGFloat != nil {
                self!.slider.value = (jum as? Float)!
                self!.progressLabel.text = String(format: "%.1f", self!.slider.value) + "%"
            }
        }
    }
    //进度条点击的时候显示的label
    func createProgressLable(){
        progressLabel = UILabel()
        progressLabel.backgroundColor = UIColor.blackColor()
        progressLabel.alpha = 0.6
        progressLabel.textColor = UIColor.whiteColor()
        progressLabel.textAlignment = .Center
        footSetView?.addSubview(progressLabel)
        progressLabel.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalTo(footSetView!.snp_top).offset(-5)
            make.width.equalTo(60)
        }
        progressLabel.hidden = true
    }
    
    
    func backClick(){
        
        navigationController?.popViewControllerAnimated(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav"), forBarMetrics: .Default)
        
    }
    func loadData(){
        let path = docPath!+"/\(bookName!)/init.txt"
        let data = NSData(contentsOfFile: path)
        do {
            //解析数据
            let dics = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [String:AnyObject]
            model=BooKLookModel()
            model!.setValuesForKeysWithDictionary(dics)
            lookBookView?.model = model
            setView?.model = model!.zhangjie
  
        }catch (let error){
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:底部设置视图
    func setLookBookView(){
        footSetView = UIView(frame: CGRectMake(0,KScreenH,KScreenW,KScreenH/8))
        footSetView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        self.view.addSubview(footSetView!)
        
        self.view.bringSubviewToFront(footSetView!)
        
        
        
        let Labels = ["上一章","下一章"]
        let images = ["setting_readhistory_19x19_","setting_icon_19x19_"]
        for i in 0..<images.count{
            
            
            
            let label = UILabel()
            label.text = Labels[i]
            label.font = UIFont.systemFontOfSize(15)
            label.textColor = UIColor.greenColor()
            label.tag = 300 + i
            label.userInteractionEnabled = true
            let g = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
            label.addGestureRecognizer(g)
            footSetView?.addSubview(label)
            if i == 0 {
                label.textAlignment = .Left
                label.snp_makeConstraints { (make) in
                    make.left.top.equalToSuperview().offset(10)
                    make.width.equalTo(60)
                    make.height.equalTo(20)
                }
            }else {
                label.textAlignment = .Right
                label.snp_makeConstraints { (make) in
                    make.top.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.width.equalTo(60)
                    make.height.equalTo(20)
                }
            }
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[i])
            footSetView?.addSubview(imageView)
            imageView.tag = 400+i
            imageView.userInteractionEnabled = true
            let towg = UITapGestureRecognizer(target: self, action: #selector(tapClick(_:)))
            imageView.addGestureRecognizer(towg)
            imageView.snp_makeConstraints(closure: { (make) in
                make.bottom.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(40)
                make.width.equalTo(imageView.snp_height)
                if i == 0 {
                    make.left.equalToSuperview().offset(10)
                }else {
                    make.right.equalToSuperview().offset(-10)
                }
            })
        }
        
        slider=UISlider()
        footSetView?.addSubview(slider)
        slider.minimumValue = 0
        slider.maximumValue = 100
        //滚动球的颜色
        //        slider.thumbTintColor = UIColor.whiteColor()
        slider.tintColor = UIColor.greenColor()
        slider.setThumbImage(UIImage(named: "novelbook_detail_rank_3_32x32_"), forState: .Normal)
        slider.continuous = true
        slider.addTarget(self, action: #selector(sliderChange(_:)), forControlEvents: .ValueChanged)
        slider.addTarget(self, action: #selector(sliderClick(_:)), forControlEvents: .TouchUpInside)
        slider.tag = 999
        slider.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-70)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
    }
    //MARK: 底部设置菜单上面的点击事件
    func tapClick(g:UIGestureRecognizer){
        if g.view?.tag == 300 {
            lookBookView?.jumChapter = true
            lookBookView?.chapter -= 1
        }else if g.view?.tag == 301 {
            lookBookView?.chapter += 1
        }else if g.view?.tag == 400 {
            if !ctrlHidden {
                
                setView?.bookName = bookName
                setView?.chapter = lookBookView?.chapter
                setView?.directoryView?.hidden = false
                setView?.segCtrl?.selectIndex = 0
                setView?.hidden = false
                
                UIView.animateWithDuration(0.5) {
                    self.lookBookView!.frame.origin.x += KScreenW/6*5
                    self.setView!.frame.origin.x += KScreenW
                    
                }
                ctrlHidden = !ctrlHidden
            }
        }else if g.view?.tag == 401 {
            
           
            UIView.animateWithDuration(0.5) {
                self.ctrlHidden = !self.ctrlHidden
                self.setLookBook?.frame.origin.y -= 120
            }
            exitBtn()
        }
    }
    
    func sliderChange(slider:UISlider){
        progressLabel.hidden = false
        progressLabel.text = String(format: "%.1f", slider.value) + "%"
    }
    //滑块停止的时候调用的方法
    func sliderClick(slider:UISlider){
        progressLabel.hidden = true
        var num=Int(slider.value/100*Float(lookBookView!.page))
        if slider.value == 100 {
            num -= 1
        }
        lookBookView?.scrollView?.contentOffset.x = CGFloat(num)*KScreenW
    }
    //MARK: 左侧视图
    func createSetView(){
        setView=SetBookView()
        setView?.frame = CGRect(x: -KScreenW, y: 0, width: KScreenW, height: KScreenH)
        self.view.addSubview(setView!)
        setView?.hidden = true
        setView?.jumClosure = {
            [weak self]
            jum in
            
            
            UIView.animateWithDuration(0.25, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self!.lookBookView!.frame.origin.x -= KScreenW/6*5
                self!.setView!.frame.origin.x -= KScreenW
                
            }) { (b) in
                self?.setView?.bookmarksView?.removeFromSuperview()
                self!.setView?.hidden=true
                
            }
            //点击右边蒙层
            if (jum as? String == "继续看书") {
                
            }else if (jum as? Int != nil) {
                //目录Cell点击后调用
                self!.lookBookView?.jumChapter = true
                self!.lookBookView?.chapter = jum as! Int
                
            }else if jum as? BeautyModel != nil {
                
                //书签Cell点击后调用
                let marks = jum as! BeautyModel
                self?.lookBookView?.record = Int(marks.record!)
                self!.lookBookView?.chapter = Int(marks.chapter!)! - 1
            }
        }
    }
    //MARK:设置文字大小和书面背景的视图
    func createSetLookBookView(){
        
        setLookBook=SetLookBook(frame: CGRectMake(0,KScreenH,KScreenW,120), imageNames: imageNameAll)
        
        setLookBook?.delegata = self
        self.view.addSubview(setLookBook!)
        setLookBook?.jum = {
            jum in
            if jum as! Int != 0 {
                self.lookBookView?.showData()
            }
        }
        
    }
}

extension LookBookViewController:SetLookBookDelegate {
    func bgCtrl(setLookBook: SetLookBook, didClickBtnAtIndex index: Int) {

            setLookBook.selectIndex = index
            lookBookView?.bgColor = UIColor(patternImage: UIImage(named: imageNameAll[index])!)
        let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject(index, forKey: "lookBookCocol")
            userDefault.synchronize()


        
    }
    func exitBtn(){
        let btn=UIButton(frame: CGRectMake(0,0,KScreenW,KScreenH-120))
        btn.addTarget(self, action: #selector(exit(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(btn)
    }
    func exit(btn:UIButton) {
        UIView.animateWithDuration(0.25) {
            self.setLookBook?.frame.origin.y += 120
        }
        btn.removeFromSuperview()
    }
}














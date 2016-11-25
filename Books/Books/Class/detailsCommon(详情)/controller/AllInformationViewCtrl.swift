//
//  AllInformationViewCtrl.swift
//  Books
//
//  Created by ZL on 16/11/2.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import SSZipArchive


class AllInformationViewCtrl: BaseViewController {
    
    
    //闭包
    var jumpClosure:SelectedJumpClosure?
    
    //下载的对象
    var session:NSURLSession?
    
    //下载任务
    var downloadTask:NSURLSessionDownloadTask?
    
    //存储暂停位置的数据
    var resumeData:NSData?
    
    //更多数据的视图
    private var informationView:AllInformationView?
    
    var models:bookModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建导航
        createNav()
        
        informationView=AllInformationView()
        view.addSubview(informationView!)
        informationView!.model = models
        informationView!.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 49, 0))
        })
        downloadBtn()
        
    }
    
    //创建导航
    func createNav(){
        let label=UILabel.createLabel("书籍详情", textAlignment: .Center, font: 16, textColor: UIColor.whiteColor())
        label.frame=CGRectMake(0, 0, 100, 40)
        navigationItem.titleView=label
        addNavBtn("icon_nav_back", text: nil, action: #selector(backClick), isLeft: true)
    }
    
    func backClick(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func downloadBtn(){
        let label = UILabel(frame: CGRect(x: 0, y: KScreenH-48-64, width: KScreenW, height: 1))
        
        label.backgroundColor=UIColor(white: 0.1, alpha: 0.5)
        self.view.addSubview(label)
        let btn=UIButton()
        
        if (DataBase.shareDataBase.selectEntity((models?.mingcheng)!) != nil) {
            btn.setTitle("点击阅读", forState: .Normal)
        }else {
            btn.setTitle("免费下载", forState: .Normal)
        }
        
        
        
        
        btn.addTarget(self, action: #selector(download(_:)), forControlEvents: .TouchUpInside)
        btn.tag = 666
        btn.backgroundColor = UIColor(patternImage: UIImage(named: "nav")!)
        btn.layer.cornerRadius = 10
        self.view.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(37)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(KScreenW/3+10)
        }
    }
    
    func download(btn:UIButton){
        if btn.titleLabel?.text == "免费下载" {
            
            btn.setTitle("正在下载", forState: .Normal)
            btn.userInteractionEnabled = false
            let str = "\(models!.mingcheng!)-\(models!.zuozhe!)"
            let Str = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
            let downStr = "http://xianyougame.com/shucheng/book/down/\(Str!).zip"
            
            let url = NSURL(string: downStr)
            //在HTTP请求头Header 里面指定接收 Accept-Encoding ： gzip
            let request = NSURLRequest(URL: url!)
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            //        config.HTTPCookieStorage
            //        config.timeoutIntervalForRequest 设置超时的时间
            //创建session对象
            session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
            //创建下载对象
            downloadTask = session?.downloadTaskWithRequest(request)
            //创建线程
            let thread=NSThread(target: self, selector: #selector(blockThread), object: nil)
            thread.start()
        }else if btn.titleLabel?.text == "点击阅读" {
            let vc = LookBookViewController()
            vc.bookName = models?.mingcheng
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    //
    func blockThread(){
        autoreleasepool {
            //开始下载
            self.downloadTask?.resume()
            //测试是否主线程
            print(NSThread.currentThread())
            NSThread.exit()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension AllInformationViewCtrl:NSURLSessionDownloadDelegate{
    //下载完成之后
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL){
        
        //        let destPath = docPath?.stringByAppendingString("/\(models!.mingcheng!).zip")
        
        //2.移动文件
        //        let fm = NSFileManager.defaultManager()
        //        try! fm.moveItemAtPath(location.path!, toPath: destPath!)
        
        
        //        print(NSHomeDirectory())
        //        print(NSThread.currentThread())//查看当前线程
        //结束下载
        session.finishTasksAndInvalidate()
        
        let tmpView = view.viewWithTag(666)
        if tmpView?.isKindOfClass(UIButton) == true{
            let tmpBtn = tmpView as! UIButton
            tmpBtn.setTitle("点击阅读", forState: .Normal)
            tmpBtn.userInteractionEnabled = true
        }
        let newFile = docPath?.stringByAppendingString("/\(models!.mingcheng!)")
        
        //location.path!是原文件的位置
        //将网络路径下的文件解压
        SSZipArchive.unzipFileAtPath(location.path!, toDestination: newFile!)
        let model = BeautyModel()
        model.booksName = models!.mingcheng!
        DataBase.shareDataBase.insertWithModel(model)
        
    }
}















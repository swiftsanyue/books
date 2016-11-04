//
//  AllInformationViewCtrl.swift
//  Books
//
//  Created by qianfeng on 16/11/2.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class AllInformationViewCtrl: BaseViewController {
    
    
    //闭包
    var jumpClosure:SelectedJumpClosure?
    
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
        btn.setTitle("免费下载", forState: .Normal)
        btn.setTitle("正在下载", forState: .Highlighted)
        btn.setTitle("点击阅读", forState: .Selected)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

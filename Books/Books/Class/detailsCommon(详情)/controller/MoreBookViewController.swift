//
//  MoreBookViewController.swift
//  Books
//
//  Created by ZL on 16/11/1.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import Alamofire

class MoreBookViewController: BaseViewController {
    
    //精选闭包
    var jumpClosure:SelectedJumpClosure?
    
    //分类闭包
    var classjump:ClassJumpClosure?
    
    
    
    var urlJson:String?
    
    var pageNuber = 2200
    
    var dataArray:[bookModel]=[]
    
    //更多数据的视图
    private var MoreView:MoreBookView?

    override func viewDidLoad() {
        super.viewDidLoad()
        MoreView = MoreBookView()
        var url:String="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22\(urlJson!)%22%2C%22page%22%3A%\(pageNuber)%22%7D"
        
        
        //下载数据
        downloadData(url)
        
        MoreView!.addRefresh((MoreView?.tbView)!,header: { [unowned self] in
            
            url = url.stringByReplacingOccurrencesOfString(String(self.pageNuber), withString: "2200")
            self.pageNuber = 2200
            self.downloadData(url)
            
        }) { [unowned self] in
            
            url = url.stringByReplacingOccurrencesOfString(String(self.pageNuber), withString: String(self.pageNuber+1))
            self.pageNuber+=1
            self.downloadData(url)
        }
        
        
    }
    //创建导航
    func createNav(title:String?,backTxte:String?){
        let label=UILabel.createLabel(title, textAlignment: .Center, font: 16, textColor: UIColor.whiteColor())
        label.frame=CGRectMake(0, 0, 100, 40)
        navigationItem.titleView=label
        addNavBtn("icon_nav_back", text: backTxte, action: #selector(backClick), isLeft: true)
    }
    
    func backClick(){
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    //下载数据
    func downloadData(url:String){
        
            Alamofire.request(.GET,url).responseJSON { (response) in
                
            
                if url.containsString("2200") {
                    self.dataArray.removeAll()
                }
                if response.result.error == nil {
                    let dics=response.result.value as! [String:AnyObject]
                    
                    let appArray=dics[self.urlJson!] as! [[String:AnyObject]]
                    for dic in appArray{
                        let wmodel=bookModel()
                        wmodel.setValuesForKeysWithDictionary(dic)
                        self.dataArray.append(wmodel)
                    }
                    
                    self.view.addSubview(self.MoreView!)
                    self.MoreView!.dataArray = self.dataArray
                    self.MoreView!.snp_makeConstraints(closure: { (make) in
                        make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
                    })
                    self.MoreView?.jumpClosure = {
                        jump in
                        if let model = jump as? bookModel {
                            let vc = AllInformationViewCtrl()
                            vc.models = model
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                self.MoreView!.tbView!.mj_header.endRefreshing()
                self.MoreView!.tbView!.mj_footer.endRefreshing()
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

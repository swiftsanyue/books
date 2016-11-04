//
//  SelectedCell.swift
//  Books
//
//  Created by qianfeng on 16/10/29.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class SelectedCell: UITableViewCell {
    
    //闭包
    var jumpClosure:SelectedJumpClosure?

    @IBOutlet weak var scrollView: UIScrollView!
    
    var dataArray:Array<bookModel>?{
        didSet{
            //显示数据
            showData()
        }
    }
    private func showData(){
        
        
        //注意:滚动视图系统默认添加了一些子视图，删除子视图时要考虑一下会不会影响这些子视图
        //删除滚动视图之前的子视图
        for sub in scrollView.subviews {
            sub.removeFromSuperview()
        }
        
        //遍历图片
        if dataArray?.count > 5 {
            
            //滚动视图加约束
            //1.创建一个容器视图,作为滚动视图的子视图
            let containerView = UIView.createView()
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(scrollView)
                //一定要设置高度
                make.height.equalTo(scrollView).offset(-1)
            })
            
            //2.循环设置子视图的约束,子视图是添加到容器视图里面
            var lastView: UIView? = nil
            
            for i in 0..<6 {
                let model = dataArray![i]
                //创建图片
                let tmpImageView = UIImageView()
                //将数据中的中文和"/"转换成url可以识别的数据
                let str = model.fengmian!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
                //%2F是"/"转换后，需要替换回去
                let str1=str!.stringByReplacingOccurrencesOfString("%2F", withString: "/")
                let url = NSURL(string: "http://xianyougame.com/shucheng/"+str1)
                //请求图片，第二个参数是默认图片，在没有请求下来的时候会显示
                tmpImageView.kf_setImageWithURL(url!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                
                //添加点击事件
                tmpImageView.userInteractionEnabled=true
                tmpImageView.tag = 200+i
                let g = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                tmpImageView.addGestureRecognizer(g)
                
                //图片的约束
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(containerView.snp_top).offset(0)
                    make.bottom.equalTo(containerView.snp_bottom).offset(-30)
                    make.width.equalTo(KScreenW/3-30)
                    if lastView == nil {
                        make.left.equalTo(containerView.snp_left).offset(30)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!).offset(30)
                    }
                })
                lastView = tmpImageView
                
                let label=UILabel.createLabel(model.mingcheng, textAlignment: .Center, font: 16, textColor: UIColor.grayColor())
                containerView.addSubview(label)
                label.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo((lastView?.snp_bottom)!)
                    make.bottom.equalTo(containerView).offset(-2)
                    make.centerX.equalTo(lastView!)
                    make.width.equalTo(lastView!)
                })
            }
            
            let bottomLabel=UILabel()
            bottomLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            scrollView.addSubview(bottomLabel)
            bottomLabel.snp_makeConstraints(closure: { (make) in
                make.bottom.equalTo(scrollView)
                make.left.equalTo(scrollView).offset(-KScreenW)
                make.right.equalTo(scrollView).offset(KScreenW)
                make.height.equalTo(1)
            })
            
            //3.修改container的宽度
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            
        }

    }
    //用父类的指针指向
    func tapImage(g:UIGestureRecognizer) {
        let index = (g.view?.tag)!-200

//        获取点击的数据
        let isBook = dataArray?[index]

        if jumpClosure != nil && dataArray?[index] != nil {
            jumpClosure!(isBook!)
        }
    }
    
    //创建cell的方法
    class func createBannerCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,dataArray:Array<bookModel>) -> SelectedCell{
        //重用标志
        let cellId = "selectedCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? SelectedCell
        if nil == cell {
            
            cell = NSBundle.mainBundle().loadNibNamed("SelectedCell", owner: nil, options: nil).last as? SelectedCell
        }
        //显示数据
        cell?.dataArray = dataArray
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  UserView.swift
//  Books
//
//  Created by ZL on 16/11/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class UserView: UIView {
    
    var lookBook : lookBookJumpClosure?
    
    var deleteC:deleteClosure?
    
    
    
    var bool=false {
        didSet{
            
            colletionView.reloadData()
        }
    }
    
    //表格
    var colletionView:UICollectionView!
    
    var model : [BeautyModel]? {
        didSet{
            colletionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        configUI()

    }
    
    func configUI(){
        //布局
        let flowLayout=UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing=20
        flowLayout.minimumLineSpacing=20
        
        colletionView=UICollectionView(frame: CGRect(x: 20, y: 20, width: KScreenW-40, height: KScreenH-94), collectionViewLayout: flowLayout)

        colletionView.clipsToBounds = false
        
        //delegate 放逻辑和布局相关的方法
        colletionView.delegate=self
        //dataSource 放和数据相关的方法
        colletionView.dataSource=self
        colletionView.showsVerticalScrollIndicator = false
        
        colletionView.backgroundColor = UIColor.whiteColor()
        colletionView.registerClass(UserCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.addSubview(colletionView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func starAnim(view:UIView) {
        // 1:创建动画对象
        let anim = CAKeyframeAnimation(keyPath: "transform.rotation")
        anim.values = [(-3 / 180 * M_PI), (3 / 180 * M_PI),(-3 / 180 * M_PI)]
        anim.repeatCount = Float(MAX_CANON)
        anim.duration = 0.25
        anim.autoreverses = true
        view.layer.addAnimation(anim, forKey: nil)
    }
    
    func stopAnim(view:UIView) {
        view.layer.removeAllAnimations()
    }
    
}

//MARK:UICollectionViewCell相关的方法
extension UserView:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model?.count != 0 {
            return (model?.count)!
        }
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (colletionView.frame.width-40)/3, height: 160)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = colletionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? UserCollectionViewCell
        
        if bool == true {
            starAnim((cell?.contentView)!)
            cell?.bool = true
        }else {
            cell?.bool = false
            stopAnim((cell?.contentView)!)
        }
        cell?.path = model![indexPath.row].booksName!
        
        let longPress=UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPress.minimumPressDuration = 1.5
        cell?.contentView.addGestureRecognizer(longPress)
        cell?.deleteC = deleteC
        
        return cell!
    }
    //cell被选中的时候调用的方法
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if lookBook != nil && model![indexPath.row].booksName != nil && bool == false{
            lookBook!(model![indexPath.row].booksName!)
        }
    }
    
    func longPress(lp:UILongPressGestureRecognizer) {
           bool = true
           deleteC!("开始删除")
    }
}

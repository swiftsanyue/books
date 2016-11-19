//
//  UILabel+common.swift
//  TestKitchen
//
//  Created by ZL on 16/10/28.
//  Copyright © 2016年 zl. All rights reserved.
//

import UIKit

extension UILabel {
    class func createLabel(text:String?,textAlignment:NSTextAlignment?,font:CGFloat?,textColor:UIColor?)->UILabel {
        let label = UILabel()
        if let tmpText = text {
            label.text = tmpText
        }
        if let tmpAlignment = textAlignment{
            label.textAlignment = tmpAlignment
        }
        if let tmpFont = font {
            //系统的是17
            label.font = UIFont.systemFontOfSize(tmpFont)
        }
        if let tmpColor = textColor {
            //系统的是17
            label.textColor = tmpColor
        }
        return label
    }
    func ViewDow(label:UILabel){
        label.layer.cornerRadius=0
        label.layer.masksToBounds=true
        label.layer.borderWidth=0
        label.layer.borderColor=nil
        label.layer.backgroundColor=nil
        label.transform = CGAffineTransformMakeScale(1, 1)
    }
}






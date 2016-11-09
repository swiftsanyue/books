//
//  Const.swift
//  Books
//
//  Created by qianfeng on 16/10/28.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

//获取沙盒目录的路径
let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last

//定义一些常量和接口
//屏幕的宽度和高度
let KScreenW = UIScreen.mainScreen().bounds.size.width
let KScreenH = UIScreen.mainScreen().bounds.size.height



//lhw_jx_1 : 表示精选 0是精品书单 1是热门书籍 2是最新完结 3是男生爱读 4是女生爱读 5是同人专区
//jx 是精选，ph排行
//220/2200是页码
//
var currentUrls = ["lhw_jx_0","lhw_jx_1","lhw_jx_2","lhw_jx_3","lhw_jx_4","lhw_jx_5"]
var currentUrl="lhw_jx_0"
var currentPage = "2200"
//精选的时候所获得的接口
//var curPage = ["220","221","222","223","224","225","226","227"]

let SelectedUrl0 = "http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_jx_0%22%2C%22page%22%3A%\(currentPage)%22%7D"
let SelectedUrl1 = "http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_jx_1%22%2C%22page%22%3A%\(currentPage)%22%7D"
let SelectedUrl2 = "http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_jx_2%22%2C%22page%22%3A%\(currentPage)%22%7D"
let SelectedUrl3 = "http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_jx_3%22%2C%22page%22%3A%\(currentPage)%22%7D"
let SelectedUrl4 = "http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_jx_4%22%2C%22page%22%3A%\(currentPage)%22%7D"
let SelectedUrl5 = "http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_jx_5%22%2C%22page%22%3A%\(currentPage)%22%7D"
let urls=[SelectedUrl0,SelectedUrl1,SelectedUrl2,SelectedUrl3,SelectedUrl4,SelectedUrl5]

//分类的接口
let classYQUrl1="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_yq_1%22%2C%22page%22%3A%220%22%7D"
let classYQUrl2="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_yq_2%22%2C%22page%22%3A%220%22%7D"
let classYQUrl3="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_yq_3%22%2C%22page%22%3A%220%22%7D"
let classYQUrl4="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_yq_4%22%2C%22page%22%3A%220%22%7D"
let classYQUrl5="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_yq_5%22%2C%22page%22%3A%220%22%7D"

//这个是全部里面的数据
let classYQUrl0="http://xianyougame.com/shucheng/phone?json=%7B%22fenlei%22%3A%22lhw_yq%22%2C%22page%22%3A%220%22%7D"





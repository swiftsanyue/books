//
//  BookMarksDataBase.swift
//  Books
//
//  Created by ZL on 16/11/17.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import CoreData

class BookMarksDataBase: NSObject {
    static let shareDataBase=BookMarksDataBase()
    private override init() {}
    
    var appDele = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //添加数据库数据
    func insertWithModel(model:BeautyModel){
        /*
         根据Entity的名字，创建Entity对象，并且放入到managedObjectContext中
         */
        
        let entity=NSEntityDescription.insertNewObjectForEntityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext) as! BookMarksBeautyEntity
        entity.bookName = model.booksName
        
        //去除字符串首尾空格和换行
        let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        model.bookMarks = model.bookMarks!.stringByTrimmingCharactersInSet(whitespace)
        if model.bookMarks!.characters.count > 60 {
            entity.bookMarks = model.bookMarks!.substringToIndex(model.bookMarks!.startIndex.advancedBy(60))
        }
        
        
        entity.chapter = NSNumber(integer: (model.chapter! as NSString).integerValue)
        
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd"
        // yy 的话是16年
        let strNowTime = timeFormatter.stringFromDate(date) as String
        entity.addTime = strNowTime
        entity.record = NSNumber(integer: (model.record! as NSString).integerValue)
        

        appDele.saveContext()
    }
    //判读数据库中是否有此条数据
    func selectEntity(bookName:String)->BookMarksBeautyEntity?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构,设置数据库中查找的表
        request.entity=NSEntityDescription.entityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
        request.fetchLimit = 1 //限定查询结果的最大数量
        
        //设置查询条件
        request.predicate=NSPredicate(format: "bookName==%@", bookName)
        do{
            //查询操作
            let objects = try appDele.managedObjectContext.executeFetchRequest(request)
            if objects.count>0{
                return objects[0] as? BookMarksBeautyEntity
            }
        }catch{
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror),\(nserror.userInfo)")
            abort()
        }
        return nil
    }
    //判读数据库中是否有此条数据,在这里做为书签的唯一标识
    func selectEntityMarks(bookMarks:String)->BookMarksBeautyEntity?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构,设置数据库中查找的表
        request.entity=NSEntityDescription.entityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
        request.fetchLimit = 1 //限定查询结果的最大数量
        
        //设置查询条件
        request.predicate=NSPredicate(format: "bookMarks==%@", bookMarks)
        do{
            //查询操作
            let objects = try appDele.managedObjectContext.executeFetchRequest(request)
            if objects.count>0{
                return objects[0] as? BookMarksBeautyEntity
            }
        }catch{
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror),\(nserror.userInfo)")
            abort()
        }
        return nil
    }
    //根据条件获取指定个数的值
    func findNameCount(bookName:String)->[BeautyModel]?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构
        request.entity=NSEntityDescription.entityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
        request.fetchLimit = 0 //限定查询结果的数量 0是全部
        
        
        
        
        
        
        request.predicate=NSPredicate(format: "bookName==%@", bookName)
        
        
        do{
            //查询操作
            let objects=try appDele.managedObjectContext.executeFetchRequest(request) as! [BookMarksBeautyEntity]
            var array:[BeautyModel]=[]
            for beauty in objects{
                let model=BeautyModel()
                if beauty.bookName != nil {
                    model.booksName = beauty.bookName
                    model.bookMarks = beauty.bookMarks
                    model.chapter = "\(beauty.chapter ?? 0)"
                    model.addTime = beauty.addTime
                    model.record = "\(beauty.record ?? 0)"
                    
                    array.append(model)
                }
            }
            return array
        }catch{
            let nserror = error as NSError
            NSLog("查询错误：\(nserror), \(nserror.userInfo)")
            
        }
        return nil
    }
    //更新数据库
    func upDateData(Model model:BeautyModel){
        let entity=DataBase.shareDataBase.selectEntity(model.booksName!)
        if entity != nil{
            //            entity?.bookMarks = model.bookMarks.NS
            
            
            
            appDele.saveContext()
        }
    }
    //删除数据库
    func deleteWith(bookMarks:String){
        //拿到entity
        let entity=self.selectEntityMarks(bookMarks)
        //用managerContext去删除entity
        appDele.managedObjectContext.deleteObject(entity!)
        //让managerContext与数据库同步
        appDele.saveContext()
    }

}

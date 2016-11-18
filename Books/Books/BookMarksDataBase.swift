//
//  BookMarksDataBase.swift
//  Books
//
//  Created by qianfeng on 16/11/17.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import CoreData

class BookMarksDataBase: NSObject {
    static let shareDataBase=BookMarksDataBase()
    private override init() {}
    
    var appDele = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func insertWithModel(model:BeautyModel){
        /*
         根据Entity的名字，创建Entity对象，并且放入到managedObjectContext中
         */
        
        let entity=NSEntityDescription.insertNewObjectForEntityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext) as! BookMarksBeautyEntity
        entity.bookName = model.booksName
        entity.bookMarks = model.bookMarks
        entity.chapter = NSNumber(integer: (model.chapter! as NSString).integerValue)
        
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyy-MM-dd"
        // yy 的话是16年
        let strNowTime = timeFormatter.stringFromDate(date) as String
        entity.addTime = strNowTime

        appDele.saveContext()
    }
    //判读数据库中是否有此条数据
    func selectEntity(bookName:String)->BookMarksBeautyEntity?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构,设置数据库中查找的表
        request.entity=NSEntityDescription.entityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
        request.fetchLimit = 1 //限定查询结果的最大数量
        /*设置排序,key是以什么排序
         参1：key 是以什么排序
         参2: true 是升序， false 是降序
         */
        //        request.sortDescriptors=[NSSortDescriptor(key: "age", ascending: true)]
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
    //根据条件获取指定个数的值
    func findNameCount(str:String)->[BeautyModel]?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构
        request.entity=NSEntityDescription.entityForName("BookMarksBeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
        request.fetchLimit = 0 //限定查询结果的数量 0是全部
        
        //        let num1=NSNumber(integer: 14)
        //        let num2=NSNumber(integer: 20)
        //BETWEEN 在两者之间
        //        request.predicate=NSPredicate(format: "age BETWEEN {%@,%@}",num1,num2)
        
        
        
        
        request.predicate=NSPredicate(format: "bookName==%@", str)
        
        //设置排序
        //        request.sortDescriptors=[NSSortDescriptor(key: "age", ascending: true)]
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
    func deleteWith(bookName:String){
        //拿到entity
        let entity=self.selectEntity(bookName)
        //用managerContext去删除entity
        appDele.managedObjectContext.deleteObject(entity!)
        //让managerContext与数据库同步
        appDele.saveContext()
    }

}

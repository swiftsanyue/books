//
//  DataBase.swift
//  Books
//
//  Created by qianfeng on 16/11/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit
import CoreData

class DataBase: NSObject {
    static let shareDataBase=DataBase()
    private override init() {}
    
    var appDele = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func insertWithModel(model:BeautyModel){
        /*
         根据Entity的名字，创建Entity对象，并且放入到managedObjectContext中
         */
        
        let entity=NSEntityDescription.insertNewObjectForEntityForName("BeautyEntity", inManagedObjectContext: appDele.managedObjectContext) as! BeautyEntity
        entity.bookName = model.booksName
        
        //将字符串转换成数字类型存储
//            entity!.age=NSNumber(integer: (model.age! as NSString).integerValue)

//            //将PNG的图片转换成二进制数据
//            UIImagePNGRepresentation(model.headImage!)
//        }
        
        //创建好Entity之后，要让managedObjectContext与数据库同步（保存）
        appDele.saveContext()
    }
    //判读数据库中是否有此条数据
    func selectEntity(bookName:String)->BeautyEntity?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构,设置数据库中查找的表
        request.entity=NSEntityDescription.entityForName("BeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
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
                return objects[0] as? BeautyEntity
            }
        }catch{
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror),\(nserror.userInfo)")
            abort()
        }
        return nil
    }
    //查找指定个数的num
    func findNameCount()->[BeautyModel]?{
        let request=NSFetchRequest()
        //设置数据请求的实体结构
        request.entity=NSEntityDescription.entityForName("BeautyEntity", inManagedObjectContext: appDele.managedObjectContext)
        request.fetchLimit = 0 //限定查询结果的数量
        
        //        let num1=NSNumber(integer: 14)
        //        let num2=NSNumber(integer: 20)
        //BETWEEN 在两者之间
        //        request.predicate=NSPredicate(format: "age BETWEEN {%@,%@}",num1,num2)
        
        //复合条件
        //        request.predicate=NSPredicate(format: "age>%@&&sex==%@", num1,"女")
        
        //%K 用来做key的占为符
        //        request.predicate=NSPredicate(format: "%K>%@", "age",num1)
        
        //设置排序
//        request.sortDescriptors=[NSSortDescriptor(key: "age", ascending: true)]
        do{
            //查询操作
            let objects=try appDele.managedObjectContext.executeFetchRequest(request) as! [BeautyEntity]
            var array:[BeautyModel]=[]
            for beauty in objects{
                let model=BeautyModel()
                if beauty.bookName != nil {
                model.booksName = beauty.bookName
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

//
//  BookMarksBeautyEntity.swift
//  Books
//
//  Created by ZL on 16/11/17.
//  Copyright © 2016年 ZL. All rights reserved.
//

import Foundation
import CoreData

class BookMarksBeautyEntity: NSManagedObject {
    @NSManaged var bookName : String?
    @NSManaged var bookMarks : String?
    @NSManaged var chapter:NSNumber?
    @NSManaged var addTime:String?
    @NSManaged var record : NSNumber?
}

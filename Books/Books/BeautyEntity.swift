//
//  BeautyEntity.swift
//  Books
//
//  Created by ZL on 16/11/8.
//  Copyright © 2016年 ZL. All rights reserved.
//

import Foundation
import CoreData

class BeautyEntity: NSManagedObject {
    
    @NSManaged var bookName : String?
    @NSManaged var record : NSNumber?
    @NSManaged var chapter:NSNumber?
}





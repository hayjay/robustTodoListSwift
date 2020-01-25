//
//  TodoCategory+CoreDataProperties.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 24/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoCategory> {
        return NSFetchRequest<TodoCategory>(entityName: "TodoItemCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

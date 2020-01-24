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

// MARK: Generated accessors for items
extension TodoCategory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

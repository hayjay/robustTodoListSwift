//
//  Item.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 24/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    //here Linking objects is just like the inverse relationship in laravel
    //which simply is the belongsTo relationship
    //the items property here is simply related to the items variable declared in the Category Model
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

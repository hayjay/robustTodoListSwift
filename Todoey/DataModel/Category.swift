//
//  Category.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 24/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import Foundation
import RealmSwift

//by subclassing or extending the Object class, we were able to save the Category to Realm
class Category : Object {
    //using dynamic helps us tell realm to monitor for changes even when the app is at runtime
    @objc dynamic var name : String = ""
//    @objc dynamic var done : Bool = false
    //List in realm is like an array : a container type
//    here we mean we have declared a list of items or an array of items
    let items = List<Item>()
    
}

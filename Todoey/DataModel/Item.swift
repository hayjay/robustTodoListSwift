//
//  Todo.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 18/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import Foundation

//adding encodable datatype to the model so that the our items can be encodable to a json format and to our pList file
//also, for a class to be encodable, all of its properties (title, done) must have a standard data type which is Sting and Bool
//class Item : Encodable, Decodable {

class Item : Codable {
    //declare a property called title
    var title: String = ""
    var done: Bool = false
}

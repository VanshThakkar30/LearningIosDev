//
//  Item.swift
//  Todoey
//
//  Created by Jinfoappz on 28/05/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date? 
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

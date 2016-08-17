//
//  KeywordObj.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 8/13/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import Foundation
import RealmSwift

class KeywordObj: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var objID = ""
    dynamic var word = ""
    
    override static func primaryKey() -> String? {
        return "objID"
    }
    
    let search = LinkingObjects(fromType: SearchObj.self, property: "keyword")
}

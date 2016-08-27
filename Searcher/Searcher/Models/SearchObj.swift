//
//  SearchObj.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 8/13/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import Foundation
import RealmSwift

class SearchObj: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    /*
    {
    "title" : "สมุนไพรไทย 22 ชนิดขึ้นบัญชียาหลักแห่งชาติ",
    "pubyear" : "2015",
    "author" : "กานดา แสนมณี",
    "keyword" : [
    {
				"word" : "สมุนไพรไทย"
    },
    {
				"word" : " บัญชียาหลักแห่งชาติ"
    }
    ],
    "url" : "http://www.thai-explore.net/search_detail/result/13",
    "affiliate" : "",
    "site_name" : "thaiex",
    "digital_file" : "true"
    }
    */
    
    dynamic var objID = ""
    dynamic var title = ""
    dynamic var pubyear = ""
    dynamic var author = ""
    dynamic var url = ""
    dynamic var affiliate = ""
    dynamic var site_name = ""
    dynamic var digital_file = ""
    dynamic var bookmarked = ""
    let keyword = List<KeywordObj>()
    
    override static func primaryKey() -> String? {
        return "objID"
    }
}

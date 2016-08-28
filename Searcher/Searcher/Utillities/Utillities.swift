//
//  Utillities.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 8/26/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//
import RealmSwift

class Utillities {
    static let sharedInstance = Utillities()
    let realm : Realm
    var queryString1:String!
    var queryString2:String!
    var queryString3:String!
    var queryString4:String!
    
    private init() {
        // Get new realm and table since we are in a new thread
        let cachesDirectoryPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
        let cachesDirectoryURL = NSURL(fileURLWithPath: cachesDirectoryPath)
        let fileURL = cachesDirectoryURL.URLByAppendingPathComponent("Search.realm")
        let config = Realm.Configuration(fileURL: fileURL)
        realm = try! Realm(configuration: config)
    } //This prevents others from using the default '()' initializer for this class.
}
//
//  SearchViewController.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 7/24/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import UIKit
import RealmSwift
//import SearchObj
//import KeywordObj

//class Dog: Object {
//    dynamic var name = ""
//    dynamic var age = 0
//}
//
//class Person: Object {
//    dynamic var name = ""
//    let dogs = List<Dog>()
//}


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var candies = [
        Candy(category:"Chocolate", name:"Chocolate Bar"),
        Candy(category:"Chocolate", name:"Chocolate Chip"),
        Candy(category:"Chocolate", name:"Dark Chocolate"),
        Candy(category:"Hard", name:"Lollipop"),
        Candy(category:"Hard", name:"Candy Cane"),
        Candy(category:"Hard", name:"Jaw Breaker"),
        Candy(category:"Other", name:"Caramel"),
        Candy(category:"Other", name:"Sour Chew"),
        Candy(category:"Other", name:"Gummi Bear")
    ]
    
    var filteredCandies = [Candy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "Search Feed"

        var image = UIImage(named: "icon_nav_search")
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        /*
        // Dumping data from JSON
        if let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    print("data amount : \(jsonResult.count) records");
                    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                    // Import many items in a background thread
                    dispatch_async(queue) {
                        // Get new realm and table since we are in a new thread
                        let cachesDirectoryPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
                        let cachesDirectoryURL = NSURL(fileURLWithPath: cachesDirectoryPath)
                        let fileURL = cachesDirectoryURL.URLByAppendingPathComponent("Search.realm")
                        let config = Realm.Configuration(fileURL: fileURL)
                        let realm = try! Realm(configuration: config)
                        
                        // Start writing data to Realm
                        realm.beginWrite()
                        for index in 0...jsonResult.count-1 {
                            let obj: NSDictionary = jsonResult.objectAtIndex(index) as! NSDictionary
                            let searchObj = SearchObj()
                            searchObj.objID = NSUUID().UUIDString
                            searchObj.title = obj["title"] as! String
                            searchObj.pubyear = obj["pubyear"] as! String
                            searchObj.author = obj["author"] as! String
                            searchObj.url = obj["url"] as! String
                            searchObj.affiliate = obj["affiliate"] as! String
                            searchObj.site_name = obj["site_name"] as! String
                            searchObj.digital_file = obj["digital_file"] as! String
                            
                            let keywordArray = obj["keyword"] as! NSArray
                            if (keywordArray.count > 0) {
                                for keywordIndex in 0...keywordArray.count-1 {
                                    
                                    let keyword = keywordArray[keywordIndex] as! NSDictionary
                                    let keywordObj = KeywordObj()
                                    keywordObj.objID = NSUUID().UUIDString
                                    keywordObj.word = keyword["word"] as! String
                                    searchObj.keyword.append(keywordObj)
                                }
                            }
                            
                            realm.add(searchObj)
                        }
                        try! realm.commitWrite()
                    }
                } catch {}
            } catch {}
        }
        */

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
//        // 1
//        let nav = self.navigationController?.navigationBar
//        // 2
//        nav?.barStyle = UIBarStyle.Black
//        nav?.tintColor = UIColor.yellowColor()
//        // 3
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .ScaleAspectFit
//        // 4
//        let image = UIImage(named: "icon_nav_search") // TODO: Change icon.
//        imageView.image = image
//        // 5
//        navigationItem.titleView = imageView
    }
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != ""
        {
            return filteredCandies.count
        }
        return candies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let candy: Candy
        if searchController.active && searchController.searchBar.text != ""
        {
            candy = filteredCandies[indexPath.row]
        }
        else
        {
            candy = candies[indexPath.row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let candy = candies[indexPath.row]
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailCandy = candy
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
    }
    
    // MARK: - Helper Methods
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCandies = candies.filter { candy in
            return candy.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    
    func backgroundAdd() {
//        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        // Import many items in a background thread
//        dispatch_async(queue) {
//            // Get new realm and table since we are in a new thread
//            let realm = try! Realm()
//            realm.beginWrite()
//            for _ in 0..<5 {
//                // Add row via dictionary. Order is ignored.
//                realm.create(DemoObject.self, value: ["title": TableViewController.randomString(), "date": TableViewController.randomDate()])
//            }
//            try! realm.commitWrite()
//        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



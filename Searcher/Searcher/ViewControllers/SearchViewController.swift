//
//  SearchViewController.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 7/24/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBarIcon: UIImageView!
    
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
    var filteredData = [SearchObj]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        definesPresentationContext = true
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        
        self.navigationItem.title = "Search Feed"

        var image = UIImage(named: "icon_nav_search")
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Add Observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.methodOfReceivedNotificationBookmark(_:)), name:"NotificationIdentifierBookmark", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchViewController.methodOfReceivedNotificationOpen(_:)), name:"NotificationIdentifierOpenLink", object: nil)
        
        
//        // Dumping data from JSON
//        if let path = NSBundle.mainBundle().pathForResource("data", ofType: "json") {
//            do {
//                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
//                do {
//                    let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
//                    
//                    print("data amount : \(jsonResult.count) records");
//                    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//                    // Import many items in a background thread
//                    dispatch_async(queue) {
//                        // Get new realm and table since we are in a new thread
//                        let cachesDirectoryPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
//                        let cachesDirectoryURL = NSURL(fileURLWithPath: cachesDirectoryPath)
//                        let fileURL = cachesDirectoryURL.URLByAppendingPathComponent("Search.realm")
//                        let config = Realm.Configuration(fileURL: fileURL)
//                        let realm = try! Realm(configuration: config)
//                        
//                        // Start writing data to Realm
//                        realm.beginWrite()
//                        for index in 0...jsonResult.count-1 {
//                            let obj: NSDictionary = jsonResult.objectAtIndex(index) as! NSDictionary
//                            let searchObj = SearchObj()
//                            searchObj.objID = NSUUID().UUIDString
//                            searchObj.title = obj["title"] as! String
//                            searchObj.pubyear = obj["pubyear"] as! String
//                            searchObj.author = obj["author"] as! String
//                            searchObj.url = obj["url"] as! String
//                            searchObj.affiliate = obj["affiliate"] as! String
//                            searchObj.site_name = obj["site_name"] as! String
//                            searchObj.digital_file = obj["digital_file"] as! String
//                            searchObj.bookmarked = "0"
//                            
//                            let keywordArray = obj["keyword"] as! NSArray
//                            if (keywordArray.count > 0) {
//                                for keywordIndex in 0...keywordArray.count-1 {
//                                    
//                                    let keyword = keywordArray[keywordIndex] as! NSDictionary
//                                    let keywordObj = KeywordObj()
//                                    keywordObj.objID = NSUUID().UUIDString
//                                    keywordObj.word = keyword["word"] as! String
//                                    searchObj.keyword.append(keywordObj)
//                                }
//                            }
//                            
//                            realm.add(searchObj)
//                        }
//                        try! realm.commitWrite()
//                    }
//                } catch {}
//            } catch {}
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        NSNotificationCenter.defaultCenter().removeObserver(self) // Remove from all notifications being observed
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchCell
        let search = filteredData[indexPath.row] as SearchObj!
        cell.titleLb?.text = search.title
        cell.authorLb?.text = search.author
        cell.publishDateLb.text = search.pubyear
        cell.searchObj = search
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160.0
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
    func filterContentForSearchText(searchText: String) {
        
        filteredData.removeAll()
        
        // Query using an NSPredicate
        let predicate = NSPredicate(format: "word BEGINSWITH %@", searchText)
        let searchResults = Utillities.sharedInstance.realm.objects(KeywordObj).filter(predicate)
        for keyword in searchResults
        {
            let searchObj : SearchObj = keyword.search[0] as SearchObj
            filteredData.append(searchObj)
        }
        
        tableView.reloadData()
    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("TextField did end editing method called")
        filterContentForSearchText(textField.text!)
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    func methodOfReceivedNotificationBookmark(notification: NSNotification){
        //Take Action on Notification
        print("bookmark tapped")
        let searchNotificationObj = notification.object as! SearchObj
        if (searchNotificationObj.bookmarked == "1")
        {
            try! Utillities.sharedInstance.realm.write {
                searchNotificationObj.setValue("0", forKey: "bookmarked")
                print("bookmark removed %@", searchNotificationObj)
            }
        }
        else
        {
            try! Utillities.sharedInstance.realm.write {
                searchNotificationObj.setValue("1", forKey: "bookmarked")
                print("bookmark added %@", searchNotificationObj)
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifierReload", object:nil)
    }
    
    func methodOfReceivedNotificationOpen(notification: NSNotification){
        //Take Action on Notification
        print("open tapped")
        let searchNotificationObj = notification.object as! SearchObj
        if let checkURL = NSURL(string: searchNotificationObj.url) {
            if UIApplication.sharedApplication().openURL(checkURL) {
                print("url successfully opened")
            }
        } else {
            print("invalid url")
        }
    }
}
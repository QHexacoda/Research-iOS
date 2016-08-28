//
//  BookmarkViewController.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 7/24/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var bookmarkTableView: UITableView!
    var filteredData = [SearchObj]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BookmarkViewController.methodOfReceivedNotificationReload(_:)), name:"NotificationIdentifierReload", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Fetch data
        self.fetchBookmarks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.titleLb?.text = String(format:"%@", search.title)
        cell.authorLb?.text = String(format:"ผู้แต่ง : %@", search.author)
        cell.sourceLb?.text = String(format:"แหล่งที่มา : %@", search.site_name.uppercaseString)
        cell.publishDateLb.text = String(format:"ปีที่เผยแพร่ : %@", search.pubyear)
        cell.searchObj = search
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 190.0
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
    func fetchBookmarks() {
        
        filteredData.removeAll()
        
        // Query using an NSPredicate
        let searchText = "1"
        let predicate = NSPredicate(format: "bookmarked BEGINSWITH %@", searchText)
        let searchResults = Utillities.sharedInstance.realm.objects(SearchObj).filter(predicate)
        for searchObj in searchResults
        {
            filteredData.append(searchObj)
        }
        
        bookmarkTableView.reloadData()
    }
    
    func methodOfReceivedNotificationReload(notification: NSNotification){
        //Take Action on Notification
        print("Reload")
        self.fetchBookmarks()
    }
}

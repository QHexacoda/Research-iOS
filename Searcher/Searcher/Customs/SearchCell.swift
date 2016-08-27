//
//  SearchCell.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 8/27/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var authorLb: UILabel!
    @IBOutlet weak var publishDateLb: UILabel!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var openBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func bookmarkTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifierBookmark", object: nil)
    }
    
    @IBAction func openTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifierOpenLink", object: nil)
    }
}
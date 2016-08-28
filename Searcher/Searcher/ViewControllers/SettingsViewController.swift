//
//  SettingsViewController.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 7/24/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var ascendingBtn: UIButton!
    @IBOutlet weak var decendingBtn: UIButton!
    @IBOutlet weak var sourceABtn: UIButton!
    @IBOutlet weak var sourceBBtn: UIButton!
    @IBOutlet weak var sourceCBtn: UIButton!
    @IBOutlet weak var sourceDBtn: UIButton!
    @IBOutlet weak var sourceLb1: UILabel!
    @IBOutlet weak var sourceLb2: UILabel!
    @IBOutlet weak var sourceLb3: UILabel!
    @IBOutlet weak var sourceLb4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ascendingBtn.centerTextAndImage(5)
        decendingBtn.centerTextAndImage(5)
        
        let border = CALayer()
        border.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0).CGColor
        border.frame = CGRect(x: 0, y: sourceLb1.frame.height, width: sourceLb1.frame.width/2, height: 0.5)
        sourceLb1.layer.addSublayer(border)
        
        let border2 = CALayer()
        border2.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0).CGColor
        border2.frame = CGRect(x: 0, y: sourceLb2.frame.height, width: sourceLb2.frame.width/2, height: 0.5)
        sourceLb2.layer.addSublayer(border2)
        
        let border3 = CALayer()
        border3.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0).CGColor
        border3.frame = CGRect(x: 0, y: sourceLb3.frame.height, width: sourceLb3.frame.width/2, height: 0.5)
        sourceLb3.layer.addSublayer(border3)
        
        let border4 = CALayer()
        border4.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0).CGColor
        border4.frame = CGRect(x: 0, y: sourceLb4.frame.height, width: sourceLb4.frame.width/2, height: 0.5)
        sourceLb4.layer.addSublayer(border4)
        
        if (sourceABtn.selected == true)
        {
            sourceABtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
        }
        else
        {
            sourceABtn.backgroundColor = UIColor.lightGrayColor()
        }
        
        if (sourceBBtn.selected == true)
        {
            sourceBBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
        }
        else
        {
            sourceBBtn.backgroundColor = UIColor.lightGrayColor()
        }
        
        if (sourceCBtn.selected == true)
        {
            sourceCBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
        }
        else
        {
            sourceCBtn.backgroundColor = UIColor.lightGrayColor()
        }
        
        if (sourceDBtn.selected == true)
        {
            sourceDBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
        }
        else
        {
            sourceDBtn.backgroundColor = UIColor.lightGrayColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    @IBAction func sourceTapped(sender: AnyObject) {
        
        if (sender.tag == 100)
        {
            if (sender.selected == true)
            {
                Utillities.sharedInstance.queryString1 = ""
                self.sourceABtn.backgroundColor = UIColor.lightGrayColor()
                self.sourceABtn.selected = false
            }
            else
            {
                Utillities.sharedInstance.queryString1 = "doi"
                self.sourceABtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
                self.sourceABtn.selected = true
            }
        }
        else if (sender.tag == 200)
        {
            if (sender.selected == true)
            {
                Utillities.sharedInstance.queryString2 = ""
                self.sourceBBtn.backgroundColor = UIColor.lightGrayColor()
                self.sourceBBtn.selected = false
            }
            else
            {
                Utillities.sharedInstance.queryString2 = "dirc"
                self.sourceBBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
                self.sourceBBtn.selected = true
            }
        }
        else if (sender.tag == 300)
        {
            if (sender.selected == true)
            {
                Utillities.sharedInstance.queryString3 = ""
                self.sourceCBtn.backgroundColor = UIColor.lightGrayColor()
                self.sourceCBtn.selected = false
            }
            else
            {
                Utillities.sharedInstance.queryString3 = "thaiex"
                self.sourceCBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
                self.sourceCBtn.selected = true
            }
        }
        else
        {
            if (sender.selected == true)
            {
                Utillities.sharedInstance.queryString4 = ""
                self.sourceDBtn.backgroundColor = UIColor.lightGrayColor()
                self.sourceDBtn.selected = false
            }
            else
            {
                Utillities.sharedInstance.queryString4 = "tnrr"
                self.sourceDBtn.backgroundColor = UIColor.init(red: 93/255.0, green: 173/255.0, blue: 226/255.0, alpha: 1.0)
                self.sourceDBtn.selected = true
            }
        }
    }
    
    @IBAction func sortTapped(sender: AnyObject) {
        if (sender.tag == 1000)
        {
            ascendingBtn.selected = true
            decendingBtn.selected = false
        }
        else
        {
            ascendingBtn.selected = false
            decendingBtn.selected = true
        }
    }
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.sharedApplication().userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .LeftToRight ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}

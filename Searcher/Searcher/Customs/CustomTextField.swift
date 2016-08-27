//
//  CustomTextField.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 8/26/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import Foundation
import UIKit

class MyCustomTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.blueColor()
        self.textColor = UIColor.whiteColor()
        self.tintColor = UIColor.purpleColor()
        
    }
}

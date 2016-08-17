//
//  CustomBar.swift
//  Searcher
//
//  Created by Weerayoot Ngandee on 8/3/2559 BE.
//  Copyright © 2559 Weerayoot Ngandee. All rights reserved.
//

import UIKit

class CustomBar: UINavigationBar {
    override func sizeThatFits(size: CGSize) -> CGSize {
        let newSize:CGSize = CGSizeMake(self.superview!.frame.size.width, 87)
        return newSize
    }
}

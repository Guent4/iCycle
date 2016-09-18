//
//  Item.swift
//  iCycle
//
//  Created by Gautham Sezhian on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject {
    
    var barcode : String
    var name : String
    var regDate: NSDate
    
    init(name: String, regDate: NSDate, barcode: String) {
        self.name = name
        self.regDate = regDate
        self.barcode = barcode
    }
}
//
//  Friend.swift
//  iCycle
//
//  Created by Gautham Sezhian on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class Friend: NSObject {
    
    var name : String
    var score : Int
    var position: Int
    
    init(name: String, score: Int, position: Int) {
        self.name = name
        self.score = score
        self.position = position
    }
}
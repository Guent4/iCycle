//
//  HomeViewController.swift
//  
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit
import Charts

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.retrieveItemsForDay();
//        DataService.retrieveItemsForWeek();
//        DataService.retrieveItemsForMonth();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


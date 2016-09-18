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
    
    @IBOutlet weak var TimeSinceLastRecycled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // let mostRecent = DataService.retrieveMostRecentItem()[0]
        // TimeSinceLastRecycled.text = mostRecent["Name"] as? String
        // DataService.retrieveItemsForDay()
        // DataService.retrieveItemsForWeek()
        // DataService.retrieveItemsForMonth()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


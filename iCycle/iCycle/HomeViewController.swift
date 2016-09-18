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
    
    var toPass: Int = 0
    var destVC: BarChartViewController!
    
    @IBOutlet weak var chartScope: UISegmentedControl!
    @IBOutlet weak var TimeSinceLastRecycled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        toPass = chartScope.selectedSegmentIndex
        // let mostRecent = DataService.retrieveMostRecentItem()[0]
        // TimeSinceLastRecycled.text = mostRecent["Name"] as? String
        // DataService.retrieveItemsForDay()
        // DataService.retrieveItemsForWeek()
        // DataService.retrieveItemsForMonth()
        // Do any additional setup after loading the view, typically from a nib.
        print(UserID);
    }
    @IBAction func onChartChange(sender: AnyObject) {
        toPass = chartScope.selectedSegmentIndex
        destVC.viewType = toPass
        destVC.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let embeddedVC = segue.destinationViewController as? BarChartViewController where segue.identifier == "EmbedSegue" {
            embeddedVC.viewType = toPass
        }
        destVC = segue.destinationViewController as! BarChartViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


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
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timeSinceLastRecycled: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let mostRecents = DataService.retrieveMostRecentItem(UserID)
        let users = DataService.retrieveUserByUserID(UserID)
        let user = users[0]
        username.text = user["Username"] as? String
        if mostRecents.count > 0 {
            // TimeSinceLastRecycled.text = mostRecent["Name"] as? String
            // DataService.retrieveItemsForDay()
            // DataService.retrieveItemsForWeek()
            // DataService.retrieveItemsForMonth()
            // Do any additional setup after loading the view, typically from a nib.
            let mostRecent = mostRecents[0]
            let start : NSDate = mostRecent["RecycleDate"] as! NSDate
            let end = NSDate();
            let seconds : Double = end.timeIntervalSinceDate(start)
            let minutes = Int(seconds / 60)
            let hours = Int(minutes / 60)
            if hours == 0 {
                timeSinceLastRecycled.text = "Recycled "+String(minutes)+" minutes ago"
            }
            else {
                timeSinceLastRecycled.text = "Recycled "+String(hours)+" hours ago"

            }
            itemDescription.text = mostRecent["Name"] as? String
        }
        else {
            timeSinceLastRecycled.text = ""
        }
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


//
//  HistoryTableViewController.swift
//  iCycle
//
//  Created by Gautham Sezhian on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewController: UITableViewController{
    
    public var bin = Array<Item>()
    
    override func viewDidLoad() {
        let user = DataService.retrieveUserByUserID(UserID)[0]
        let items = DataService.retrieveMostRecentItems(UserID, count: user["DefaultCountHistory"] as! Int)
        
        for item in items {
            let name = item["Name"] as! String
            let regDate = item["RecycleDate"] as! NSDate
            let barcode = item["Barcode"] as! String
            bin.append(Item(name: name, regDate: regDate, barcode: barcode))
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bin.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! HistoryTableViewCell
        
        cell.itemName.text = bin[indexPath.row].name
        cell.itemData.text = "Recycled on: \(bin[indexPath.row].regDate)"
        
        
        
        return cell
    }
}
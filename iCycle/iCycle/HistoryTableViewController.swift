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
    
    override func viewDidLoad() {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let bin = [Item(name: "Dasani - 1L", regDate: NSDate(), barcode: "1234567890"), Item(name: "Red Bull - 250 mL", regDate: NSDate(), barcode: "1234567890"), Item(name: "Nesquick - 300 mL", regDate: NSDate(), barcode: "1234567890"), Item(name: "Gatorade - 20 fl. oz", regDate: NSDate(), barcode: "1234567890"), Item(name: "Poland Springs - 1 gal", regDate: NSDate(), barcode: "1234567890"), Item(name: "Dasani - 500 mL", regDate: NSDate(), barcode: "1234567890")]
    
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
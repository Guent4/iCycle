//
//  FriendsTableViewController.swift
//  iCycle
//
//  Created by Gautham Sezhian on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class FriendsTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let posse = [Friend(name: "Adam", score: 30, position: 1), Friend(name: "Barry", score: 24, position: 2), Friend(name: "Connie", score: 12, position: 3), Friend(name: "Dan", score: 10, position: 4), Friend(name: "Eric", score: 9, position: 5)]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posse.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as! FriendsTableViewCell
        
        cell.friendName.text = posse[indexPath.row].name
        cell.friendScore.text = "Weekly Count: \(posse[indexPath.row].score)"
        cell.friendPosition.text = "Leaderboard Position: \(posse[indexPath.row].position)"
        
        
        
        return cell
    }
}
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
    
    public var bin = Array<Friend>()
    
    override func viewDidLoad() {
        let user = DataService.retrieveUserByUserID(UserID)[0]
        let friends = DataService.retrieveLeaderBoard(UserID, limit: user["DefaultFriendHistory"] as! Int)
        
        var i : Int = 1
        for friend in friends {
            let name = friend["Username"] as! String
            let count = Int(truncatingBitPattern: (friend["Count"] as! Int64))
            bin.append(Friend(name: name, score: count, position: i))
            i = i + 1
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    let posse = [Friend(name: "Adam", score: 30, position: 1), Friend(name: "Barry", score: 24, position: 2), Friend(name: "Connie", score: 12, position: 3), Friend(name: "Dan", score: 10, position: 4), Friend(name: "Eric", score: 9, position: 5)]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bin.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as! FriendsTableViewCell
        
        cell.friendName.text = bin[indexPath.row].name
        cell.friendScore.text = "Weekly Count: \(bin[indexPath.row].score)"
        cell.friendPosition.text = "Leaderboard Position: \(bin[indexPath.row].position)"
        
        
        
        return cell
    }
}
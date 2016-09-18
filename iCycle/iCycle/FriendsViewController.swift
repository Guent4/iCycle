//
//  FriendsViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var userAdd: UITextField!
    
    @IBAction func addPressed(sender: AnyObject) {
        let text: String! = userAdd.text
        let users = DataService.retrieveUserByUsername(text!)
        let user = users[0]
        DataService.addFriend(UserID, friendID: user["UserID"] as! Int)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

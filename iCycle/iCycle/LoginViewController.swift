//
//  LoginViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit
import MySqlSwiftNative
import Charts

var UserID:Int = 0;

class LoginViewController: UIViewController {
    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var PasswordIncorrectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClick(sender: AnyObject) {
        let username = UsernameText.text!;
        let password = PasswordText.text!;
        
        let con = MySQL.Connection();
        let db_name = "iCycle";
        
        do {
            try con.open("52.165.33.228", user: "root", passwd: "password");
            try con.use(db_name);
            
            let select_stmt = try con.prepare("SELECT * FROM User WHERE (Username=?) AND (Password=?);");
            
            let res = try select_stmt.query([username, password]);
            var rows = try res.readAllRows();
            
            if (rows?.count > 0) {
                var user = rows![0][0];
                UserID = user["UserID"] as! Int;
                
                // Go to home view
                let next = self.storyboard!.instantiateViewControllerWithIdentifier("TabViewController") as UIViewController;
                self.presentViewController(next, animated: true, completion: nil);
                PasswordIncorrectLabel.hidden = true;
            } else {
                PasswordText.text = "";
                PasswordIncorrectLabel.hidden = false;
            }
        } catch (let e) {
            print(e)
        }

        
    }
    
}

//
//  SignUpViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit
import MySqlSwiftNative

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var ConfPasswordText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var ConfEmailText: UITextField!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var PassNotMatchLabel: UILabel!
    @IBOutlet weak var EmailNotMatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func SignUpClick(sender: AnyObject) {
        let username = UsernameText.text!;
        let password = PasswordText.text!;
        let confPassword = ConfPasswordText.text!;
        let email = EmailText.text!;
        let confEmail = ConfEmailText.text!;
        
        if (username == "") {
            
        } else if (password == "") {
            
        } else if (confPassword == "") {
            
        } else if (email == "") {
            
        } else if (confEmail == "") {
            
        } else {
            if (password != confPassword || email != confEmail) {
                PassNotMatchLabel.hidden = (password == confPassword);
                EmailNotMatchLabel.hidden = (email == confEmail);
            } else {
                // Everything is good; might need to check with database
                let con = MySQL.Connection();
                let db_name = "iCycle";
            
                do {
                    try con.open("52.165.33.228", user: "root", passwd: "password");
                    try con.use(db_name);
                
                    // Insert the user; if operation failed, will go to catch
                    let insert_stmt = try con.prepare("INSERT INTO User(Username,Password,Email) VALUES(?,?,?);");
                    try insert_stmt.query([username, password, email]);
                    
                    // Get the user information back from the database
                    let select_stmt = try con.prepare("SELECT * FROM User WHERE (Username=?) AND (Password=?);");
                    let res = try select_stmt.query([username, password]);
                    var rows = try res.readAllRows();
                
                    if (rows?.count > 0) {
                        var user = rows![0][0];
                        UserID = user["UserID"] as! Int;
                    
                        // Dismiss the modal
                        self.dismissViewControllerAnimated(true, completion: nil);
                        
                        // Go to home view
                        let next = self.storyboard!.instantiateViewControllerWithIdentifier("TabViewController") as UIViewController;
                        self.presentViewController(next, animated: true, completion: nil);
                    } else {
                        print("sign up issue");
                    }
                } catch (let e) {
                    print(e)
                }
            }
        }
    }
}

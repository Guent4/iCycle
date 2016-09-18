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

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
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
        super.viewDidLoad();
        UsernameText.delegate = self;
        PasswordText.delegate = self;
        ConfPasswordText.delegate = self;
        EmailText.delegate = self;
        ConfPasswordText.delegate = self;
        
        UsernameText.autocorrectionType = UITextAutocorrectionType.No;
        PasswordText.autocorrectionType = UITextAutocorrectionType.No;
        ConfPasswordText.autocorrectionType = UITextAutocorrectionType.No
        EmailText.autocorrectionType = UITextAutocorrectionType.No;
        ConfPasswordText.autocorrectionType = UITextAutocorrectionType.No;
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
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
            UsernameText.becomeFirstResponder();
        } else if (password == "") {
            PasswordText.becomeFirstResponder();
        } else if (confPassword == "") {
            ConfPasswordText.becomeFirstResponder();
        } else if (email == "") {
            EmailText.becomeFirstResponder();
        } else if (confEmail == "") {
            ConfEmailText.becomeFirstResponder();
        } else {
            PassNotMatchLabel.hidden = (password == confPassword);
            EmailNotMatchLabel.hidden = (email == confEmail);
            
            if (password == confPassword && email == confEmail) {
                if (isValidEmail(email) == false) {
                    let alert = UIAlertController(title: "Error", message: "Not a valid email address!", preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil));
                    self.presentViewController(alert, animated: true, completion: nil);
                    EmailText.becomeFirstResponder();
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
                        
                            // Go to home view
                            let next = self.storyboard!.instantiateViewControllerWithIdentifier("TabViewController") as UIViewController;
                            self.presentViewController(next, animated: true, completion: nil);
                        } else {
                            print("sign up issue");
                        }
                    } catch (let e) {
                        let alert = UIAlertController(title: "Error", message: "Username is already in use. Please pick a new username!", preferredStyle: UIAlertControllerStyle.Alert);
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil));
                        self.presentViewController(alert, animated: true, completion: nil);
                    
                        print(e)
                    }
                }
            }
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

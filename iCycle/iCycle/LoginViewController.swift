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

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var PasswordIncorrectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsernameText.delegate = self;
        PasswordText.delegate = self;

        UsernameText.autocorrectionType = UITextAutocorrectionType.No;
        PasswordText.autocorrectionType = UITextAutocorrectionType.No;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func loginClick(sender: AnyObject) {
        let username = UsernameText.text!;
        let password = PasswordText.text!;
        
        var rows = DataService.login(username, password: password);
            
        if (rows.count > 0) {
            var user = rows[0];
            UserID = user["UserID"] as! Int;
            
            // Go to home view
            let next = self.storyboard!.instantiateViewControllerWithIdentifier("TabViewController") as UIViewController;
            self.presentViewController(next, animated: true, completion: nil);
            PasswordIncorrectLabel.hidden = true;
        } else {
            PasswordText.text = "";
            PasswordIncorrectLabel.hidden = false;
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

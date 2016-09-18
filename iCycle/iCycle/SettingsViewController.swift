//
//  SettingsViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPassConfirm: UITextField!
    @IBOutlet weak var PassNotMatchLabel: UILabel!
    @IBOutlet weak var numHistory: UISegmentedControl!
    @IBOutlet weak var numFriends: UISegmentedControl!
    
    @IBAction func changePassword(sender: AnyObject) {
        let oldPass = oldPassword.text!;
        let newPass = newPassword.text!;
        let newPassConf = newPassConfirm.text!;
        
        if (oldPass == "") {
            oldPassword.becomeFirstResponder();
        } else if (newPass == "") {
            newPassword.becomeFirstResponder();
        } else if (newPassConf == "") {
            newPassConfirm.becomeFirstResponder();
        } else {
            PassNotMatchLabel.hidden = (newPass == newPassConf);
            
            // Make sure that the new password and the confirm password are the same
            if (newPass == newPassConf) {
                if (DataService.checkPassword(UserID, password: oldPass).count > 0) {
                    DataService.updatePassword(UserID, newPassword: newPass)
                    
                    // Clear the fields
                    oldPassword.text = "";
                    newPassword.text = "";
                    newPassConfirm.text = "";
                    
                    // Alert user that the password was successfully updated
                    let alert = UIAlertController(title: "Success", message: "Password was successfully updated!", preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil));
                    self.presentViewController(alert, animated: true, completion: nil);
                } else {
                    // Password was not able to be updated
                    let alert = UIAlertController(title: "Error", message: "Unable to update password.", preferredStyle: UIAlertControllerStyle.Alert);
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil));
                    self.presentViewController(alert, animated: true, completion: nil);
                }
            }
        }
    }

    //Link this IBAction to the button
    @IBAction func updateSettings(sender: UIButton){
        let itemsHistory = numHistory.titleForSegmentAtIndex(numHistory.selectedSegmentIndex) as! Int
        
        let countFriends = numFriends.titleForSegmentAtIndex(numFriends.selectedSegmentIndex) as! Int
        
        //insert these values into the database
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        oldPassword.delegate = self;
        newPassword.delegate = self;
        newPassConfirm.delegate = self;
        
        oldPassword.autocorrectionType = UITextAutocorrectionType.No;
        newPassword.autocorrectionType = UITextAutocorrectionType.No;
        newPassConfirm.autocorrectionType = UITextAutocorrectionType.No
        
        var numHistoryValue = 0
        if (DefaultCountHistory == 10) {
            numHistoryValue = 0
        } else if (DefaultCountHistory == 25) {
            numHistoryValue = 1
        } else if (DefaultCountHistory == 50) {
            numHistoryValue = 2
        }
        
        numHistory.selectedSegmentIndex = numHistoryValue
        
        var numFriendValue = 0
        if (DefaultCountFriend == 5) {
            numFriendValue = 0
        } else if (DefaultCountFriend == 10) {
            numFriendValue = 1
        } else if (DefaultCountFriend == 25) {
            numFriendValue = 2
        }	
        
        numFriends.selectedSegmentIndex = numFriendValue
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}
//
//  SettingsViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var newPassConfirm: UITextField!
    
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
            //PassNotMatchLabel.hidden = (newPass == newPassConf);
            
            //check oldPass with DB password, and then insert new password into DB, also create variable for PassNotMatchLabel
        }
        
    }
    @IBOutlet weak var numHistory: UISegmentedControl!
    
    @IBOutlet weak var numFriends: UISegmentedControl!

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
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
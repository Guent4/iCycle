//
//  SettingsViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var newPassConfirm: UITextField!
    
    @IBAction func changePassword(sender: AnyObject) {
    }
    @IBOutlet weak var numHistory: UISegmentedControl!
    
    @IBOutlet weak var numFriends: UISegmentedControl!
    @IBOutlet weak var updateSettings: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
//
//  SignUpViewController.swift
//  iCycle
//
//  Created by David Gu on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

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
    }
    
}

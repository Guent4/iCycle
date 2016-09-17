//
//  ViewController.swift
//  iCycle
//
//  Created by David Gu on 9/16/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import UIKit
import MySqlSwiftNative
import CommonCrypto

class ViewController: UIViewController {
    
    @IBOutlet weak var tBar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testDatabase();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testDatabase() {
        let con = MySQL.Connection();	
        let db_name = "iCycle";
        
        do {
            try con.open("52.165.33.228", user: "root", passwd: "password");
            try con.use(db_name);
            
            let select_stmt = try con.prepare("SELECT * FROM User;");
            
            let res = try select_stmt.query([]);
            
            print("hello");
            
            let rows = try res.readAllRows();
            
            print(rows);
        }
        catch (let e) {
            print(e)
        }
        
    }
    
    func sha256(str : String) -> NSData {
        let nsString = str as NSString
        let data = nsString.dataUsingEncoding(NSUTF8StringEncoding)
        var hash = [UInt8](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
        let res = NSData(bytes: hash, length: Int(CC_SHA256_DIGEST_LENGTH))
        return res
    }
}


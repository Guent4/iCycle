//
//  DataService.swift
//  CDBarcodes
//
//  Created by Matthew Maher on 1/29/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MySqlSwiftNative


class DataService {
    
    static let dataService = DataService()
    
    static func registerItem(codeNumber: String) {
        let upcURL = "http://api.upcdatabase.org/json/8e60c246584c5ee113c65a4fb534a14a/"+codeNumber
        Alamofire.request(.GET, upcURL)
            .responseJSON { response in
                var json = JSON(response.result.value!)
                let description = "\(json["description"])"
                let con = MySQL.Connection();
                let db_name = "iCycle";
                do {
                    try con.open("52.165.33.228", user: "root", passwd: "password");
                    try con.use(db_name);
                    print(codeNumber);
                    print(description);
                    let ins_stmt = try con.prepare("INSERT INTO Item (Barcode, Name, RegistrationDate) VALUES (?,?,?)");
                    try ins_stmt.exec([codeNumber, description, NSDate()]);

                }
                catch (let e) {
                    print(e)
                }
        }
    }
    
    static func retrieveItems() {
        
    }
}
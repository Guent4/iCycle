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
    
    static func registerItem(code: String) {
        let upcURL = String(format: "http://api.upcdatabase.org/json/%@/%@", API_KEY, code)
        Alamofire.request(.GET, upcURL)
            .responseJSON {response in
                var json = JSON(response.result.value!)
                let description = "\(json["description"])"
                let con = MySQL.Connection()
                do {
                    try con.open(DB_HOST, user: DB_USERNAME, passwd: DB_PASSWORD)
                    try con.use(DB_NAME)
                    let ins_stmt = try con.prepare("INSERT INTO Item (Barcode, Name, RegistrationDate) VALUES (?,?,?)")
                    try ins_stmt.exec([code, description, NSDate()])
                }
                catch (let e) {
                    print(e)
                }
        }
    }
    
    static func retrieveItemsForDay() {
        let con = MySQL.Connection();
        do {
            try con.open(DB_HOST, user: DB_USERNAME, passwd: DB_PASSWORD)
            try con.use(DB_NAME)
            let select_stmt = try con.prepare(GET_ITEMS_WITHIN_DAY)
            let res = try select_stmt.query([])
            let rows = try res.readAllRows()
            print(rows);
        }
        catch (let e) {
            print(e)
        }
    }

    static func retrieveItemsForWeek() {
        let con = MySQL.Connection()
        do {
            try con.open(DB_HOST, user: DB_USERNAME, passwd: DB_PASSWORD)
            try con.use(DB_NAME)
            let select_stmt = try con.prepare(GET_ITEMS_WITHIN_WEEK)
            let res = try select_stmt.query([])
            let rows = try res.readAllRows()
            print(rows)
        }
        catch (let e) {
            print(e)
        }
    }

    static func retrieveItemsForMonth() {
        let con = MySQL.Connection();
        do {
            try con.open(DB_HOST, user: DB_USERNAME, passwd: DB_PASSWORD)
            try con.use(DB_NAME)
            let select_stmt = try con.prepare(GET_ITEMS_WITHIN_MONTH)
            let res = try select_stmt.query([])
            let rows = try res.readAllRows()
            print(rows)
        }
        catch (let e) {
            print(e)
        }
    }
}
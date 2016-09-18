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
    
    static func recycleItem(userID : Int, itemCode: String, recyclerCode: String) {
        let upcURL = String(format: "http://api.upcdatabase.org/json/%@/%@", API_KEY, itemCode)
        Alamofire.request(.GET, upcURL)
            .responseJSON {response in
                var json = JSON(response.result.value!)
                let description = "\(json["description"])"
                let itemsByBarcode = query(GET_ITEMS_BY_BARCODE, data: [itemCode])
                if itemsByBarcode.count == 0 {
                    let result = execute(INSERT_ITEM, data: [itemCode, description, NSDate()])
                    if result > 0 {
                        print("failed to insert item")
                        return;
                    }
                }
                let items = query(GET_ITEMS_BY_BARCODE, data: [itemCode])
                let item = items[0]
                let recyclers = retrieveRecyclersByBarcode(recyclerCode)
                let recycler = recyclers[0]
                let recyclerID = recycler["RecyclerID"]
                execute(INSERT_RECYCLE, data: [userID, recyclerID, item["ItemID"], NSDate()])
        }
    }
    
    static func retrieveMostRecentItem(userID : Int) -> Array<Dictionary<String,protocol<>>> {
        return query(GET_MOST_RECENT_ITEM, data: [userID])
    }
    
    static func retrieveMostRecentItems(userID : Int, count : Int) -> Array<Dictionary<String,protocol<>>> {
        return query(GET_RECENT_ITEMS, data: [userID, count])
    }

    static func retrieveItemsForDay(userID : String) -> Array<Dictionary<String,protocol<>>>{
        return query(GET_ITEMS_WITHIN_DAY, data: [userID])
    }

    static func retrieveItemsForWeek(userID : Int) -> Array<Dictionary<String,protocol<>>>{
        return query(GET_ITEMS_WITHIN_WEEK, data: [userID])
    }

    static func retrieveItemsForMonth(userID : Int) -> Array<Dictionary<String,protocol<>>>{
        return query(GET_ITEMS_WITHIN_MONTH, data: [userID])
    }
    
    static func addFriend(userID: Int, friendID : Int) {
        let result = execute(ADD_FRIEND, data: [userID, friendID])
        if result > 0 {
            print("failed to add friend")
        }
    }
    
    static func retrieveFriends(userID : Int) -> Array<Dictionary<String,protocol<>>>{
        return query(GET_FRIENDS, data: [userID, userID])
    }
    
    static func updatePassword(userID : Int, password : String) {
        let result = execute(UPDATE_PASSWORD, data: [userID, password])
        if result > 0 {
            print("failed to update password")
        }
    }
    
    static func retrieveUserByUserID(userID : Int) -> Array<Dictionary<String,protocol<>>>{
        return query(GET_USER_BY_USERID, data: [userID])
    }
    
    static func retrieveRecyclersByBarcode(barcode : String) -> Array<Dictionary<String,protocol<>>>{
        return query(GET_RECYCLERS, data: [barcode])
    }
    
    static func execute(query: String, data: Array<Any> = []) -> Int {
        let con = MySQL.Connection()
        do {
            try con.open(DB_HOST, user: DB_USERNAME, passwd: DB_PASSWORD)
            try con.use(DB_NAME)
            let ins_stmt = try con.prepare(query)
            try ins_stmt.exec(data)
            return 0
        }
        catch (let e) {
            print(e)
            return 1
        }
    }
    
    static func query(query: String, data: Array<Any> = []) -> Array<Dictionary<String,protocol<>>>{
        let con = MySQL.Connection();
        do {
            try con.open(DB_HOST, user: DB_USERNAME, passwd: DB_PASSWORD)
            try con.use(DB_NAME)
            let select_stmt = try con.prepare(query)
            let res = try select_stmt.query(data)
            let rows = try res.readAllRows()
            if rows!.count == 0 {
                return []
            }
            return rows![0]
        }
        catch (let e) {
            print(e)
            return []
        }
    }
}
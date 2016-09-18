//
//  Constants.swift
//  iCycle
//
//  Created by Deeban Ramalingam on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation

let URL_BASE = "http://api.upcdatabase.org/json/%@/%@"
let API_KEY = "8e60c246584c5ee113c65a4fb534a14a"

let DB_HOST = "52.165.33.228"
let DB_NAME = "iCycle"
let DB_USERNAME = "root"
let DB_PASSWORD = "password"

let LOGIN = "SELECT * FROM User WHERE (Username=?) AND (Password=?);"
let CHECK_PASSWORD = "SELECT * FROM User WHERE (UserID=?) AND (Password=?);"
let UPDATE_PASSWORD = "UPDATE iCycle.User SET Password = ? WHERE UserID = ?;"

let INSERT_ITEM = "INSERT INTO iCycle.Item (Barcode, Name, RegistrationDate) VALUES (?,?,?)"
let GET_ITEMS_BY_BARCODE = "SELECT * FROM iCycle.Item WHERE Barcode=?"

let INSERT_RECYCLE = "INSERT INTO iCycle.Recycling (UserID, RecyclerID, ItemID, RecycleDate) VALUES (?,?,?,?)"

let GET_ITEMS_WITHIN_DAY = "SELECT * FROM iCycle.Recycling INNER JOIN iCycle.Item ON iCycle.Recycling.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycling.UserID = ? AND RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 DAY) ORDER BY RegistrationDate DESC"
let GET_ITEMS_WITHIN_WEEK = "SELECT * FROM iCycle.Recycling INNER JOIN iCycle.Item ON iCycle.Recycling.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycling.UserID = ? AND RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 WEEK) ORDER BY RegistrationDate DESC"
let GET_ITEMS_WITHIN_MONTH = "SELECT * FROM iCycle.Recycling INNER JOIN iCycle.Item ON iCycle.Recycling.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycling.UserID = ? AND RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 MONTH) ORDER BY RegistrationDate DESC"
let GET_MOST_RECENT_ITEM = "SELECT * FROM iCycle.Recycling INNER JOIN iCycle.Item ON iCycle.Recycling.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycling.UserID = ? ORDER BY RecycleDate DESC LIMIT 1"
let GET_RECENT_ITEMS = "SELECT * FROM iCycle.Recycling INNER JOIN iCycle.Item ON iCycle.Recycling.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycling.UserID = ? ORDER BY RecycleDate DESC LIMIT ?"

let ADD_FRIEND = "INSERT INTO iCycle.Friendship (RequesterID, RequesteeID) VALUES (?,?)"
let GET_FRIENDS = "SELECT * FROM FRIENDSHIP WHERE requesterID = ? or requesteeID = ?"

let GET_USER_BY_USERID = "SELECT * FROM iCycle.User WHERE UserID = ?"
let GET_USER_BY_USERNAME = "SELECT * FROM iCycle.User WHERE Username = ?"

let ADD_RECYCLER = "INSERT INTO iCycle.Recycler (Barcode, Location) VALUES (?,?)"
let GET_RECYCLERS = "SELECT * FROM iCycle.Recycler WHERE Barcode = ?"

var SCAN_STATE = [false, false]
var SCAN_RECENT = ["", ""]
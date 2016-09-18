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

let INSERT_ITEM = "INSERT INTO iCycle.Item (Barcode, Name, RegistrationDate) VALUES (?,?,?)"
let INSERT_RECYCLE = "INSERT INTO iCycle.Recycle (UserID, RecyclerID, ItemID, RecycleDate) VALUES (?,?,?)"
let GET_ITEMS_WITHIN_DAY = "SELECT * FROM iCycle.Recycle RIGHT JOIN iCycle.Item ON iCycle.Recycle.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycle.UserID = ? AND RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 DAY) ORDER BY RegistrationDate DESC"
let GET_ITEMS_WITHIN_WEEK = "SELECT * FROM iCycle.Recycle RIGHT JOIN iCycle.Item ON iCycle.Recycle.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycle.UserID = ? AND RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 WEEK) ORDER BY RegistrationDate DESC"
let GET_ITEMS_WITHIN_MONTH = "SELECT * FROM iCycle.Recycle RIGHT JOIN iCycle.Item ON iCycle.Recycle.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycle.UserID = ? AND RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 MONTH) ORDER BY RegistrationDate DESC"
let GET_MOST_RECENT_ITEM = "SELECT * FROM iCycle.Recycle RIGHT JOIN iCycle.Item ON iCycle.Recycle.ItemID = iCycle.Item.ItemID WHERE iCycle.Recycle.UserID = ? ORDER BY RecycleDate DESC LIMIT 1"
let GET_ITEMS_BY_BARCODE = "SELECT * FROM iCycle.Item WHERE Barcode=?"
let ADD_FRIEND = "INSERT INTO Friendship (RequesterID, RequesteeID) VALUES (?,?)"
let GET_FRIENDS = "SELECT * FROM FRIENDSHIP WHERE requesterID = ? or requesteeID = ?"
let GET_ALL_USERS = "SELECT * FROM iCycle.User"
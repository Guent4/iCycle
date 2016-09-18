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

let GET_ITEMS_WITHIN_DAY = "SELECT * FROM iCycle.Item RegistrationDate WHERE RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 DAY) ORDER BY RegistrationDate DESC;"
let GET_ITEMS_WITHIN_WEEK = "SELECT * FROM iCycle.Item RegistrationDate WHERE RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 WEEK) ORDER BY RegistrationDate DESC;"
let GET_ITEMS_WITHIN_MONTH = "SELECT * FROM iCycle.Item RegistrationDate WHERE RegistrationDate > DATE_SUB(NOW(), INTERVAL 1 MONTH) ORDER BY RegistrationDate DESC;"
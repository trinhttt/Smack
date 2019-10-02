//
//  Constants.swift
//  Smack
//
//  Created by Trinh Thai on 9/20/19.
//  Copyright © 2019 Trinh Thai. All rights reserved.
//

import Foundation


typealias completionHandler = (_ Success: Bool) -> ()

// URL Constants
let URL_BASE = "https://smackchatapp02.herokuapp.com/v1/"
let URL_REGISTER = "\(URL_BASE)account/register"
let URL_LOGIN = "\(URL_BASE)account/login"
// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]



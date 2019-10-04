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
let URL_USER_ADD = "\(URL_BASE)user/add"

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

//Colors
let smackBluePlaceholder = #colorLiteral(red: 0.2, green: 0.7019607843, blue: 0.9843137255, alpha: 1)



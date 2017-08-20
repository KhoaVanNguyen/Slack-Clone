//
//  Constants.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation

 // segues
let TO_LOGIN = "to_login"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwind"
let TO_CHOOSE_AVATAR = "toChooseAvatar"

// user authentication

let IS_LOGGED_IN = "is_logged_in"
let LOGGIN_EMAIL = "login_email"
let TOKEN = "token"
let headers = [
    "Content-Type": "application/json; charset=utf-8"
]

// URL

let BASE_URL = "http://localhost:3005/v1"
let REGISTER_URL = "\(BASE_URL)/account/register"
let LOGIN_URL = "\(BASE_URL)/account/login"
let ADDUSER_URL = "\(BASE_URL)/user/add"
let ADD_CHANNEL_URL = "\(BASE_URL)/channel/add"
let FETCH_ALL_CHANNEL = "\(BASE_URL)/channel"

// Notification

let NOTI_USERDATA_CHANGE = Notification.Name("notiUserDataChange")









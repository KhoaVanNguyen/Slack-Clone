//
//  AuthService.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AuthService{
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool{
        get{
            guard let logged = defaults.value(forKey: IS_LOGGED_IN)  else {
                return false
            }
            return logged as! Bool
        }
        set{
            defaults.set(newValue, forKey: IS_LOGGED_IN)
        }
    }
    
    var loggedInEmail: String {
        
        get {
            return defaults.value(forKey: LOGGIN_EMAIL) as! String
        }
        
        set {
            defaults.set(newValue, forKey: LOGGIN_EMAIL)
        }
    }
    
    var token: String{
        get{
            return defaults.value(forKey: TOKEN) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN)
        }
    }
    
    func createAccount(email: String, password: String, completion: @escaping (_ success: Bool) -> Void  ) {
        
        
        
        let parameters = [
            "email": email,
            "password": password,
            ]
        
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers ).responseString { (response) in
            if response.result.error != nil {
                completion(false)
            }else{
                completion(true)
            }
            
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void ){
        let parameters = [
            "email": email,
            "password": password,
            ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.error != nil {
                completion(false)
            }else {
                //                if let data = response.result.value as? Dictionary<String,Any> {
                //                    print(data)
                //                    if let token = data["token"] as? String{
                //                        self.token = token
                //                    }
                //                    if let email = data["user"] as? String{
                //
                //                        self.loggedInEmail = email
                //                    }
                //                }
                
                guard let data = response.data else { return }
                debugPrint(data)
                do {
                    let json = try JSON(data: data)
                    
                    self.isLoggedIn = true
                    self.loggedInEmail = json["email"].stringValue
                    self.token = json["token"].stringValue
                    print(self.token)
                    
                }catch{
                    print("Error when using SwiftyJSON")
                }
                
                
                completion(true)
            }
        }
    }
    
    
    func createUserData(email: String,username: String, avatarName: String,avatarColor: String, completion: @escaping (Bool) -> Void){
        
        
        let parameters = [
            "name": username,
            "email": email,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        let createUserHeader = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(self.token)"
        ]
        
        Alamofire.request(ADDUSER_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: createUserHeader).response { (response) in
            
            if response.error != nil {
                completion(false)
            }else {
                
                guard let data = response.data else { return }
                
                do {
                    let json = try JSON(data: data)
                    
                    
                    let _id = json["_id"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let avatarColor = json["avatarColor"].stringValue
                    
                    
                    UserDataService.instance.setUserData(id: _id, email: email, name: name, avatarName: avatarName, avatarColor: avatarColor)
                    
                    
                }catch{
                    debugPrint("Can't create user data")
                }
                
                completion(true)
            }
            
            
            
        }
        
        
        
        
    }
    
    func logout(){
        isLoggedIn = false
        token = ""
        loggedInEmail = ""
        UserDataService.instance.logout()
        
    }
}














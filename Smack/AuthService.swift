//
//  AuthService.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import Alamofire
class AuthService{
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool{
        get{
            return defaults.value(forKey: IS_LOGGED_IN) as! Bool
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
                if let data = response.result.value as? Dictionary<String,Any> {
                    print(data)
                    if let token = data["token"] as? String{
                        self.token = token
                    }
                    if let email = data["user"] as? String{
                        
                        self.loggedInEmail = email
                    }
                }
                completion(true)
            }
        }
    }
    
}














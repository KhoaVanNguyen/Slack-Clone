//
//  Message.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Message {
    
    static var instance = Message()
    
    
    func fetchMessageInChannel(id: String, complete: @escaping (JSON) -> Void ) {
        let header = [
            "Authorization": "Bearer \(AuthService.instance.token)"
        ]
        
        Alamofire.request("\(FETCH_MESSAGE_URL)\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error != nil {
                return
            }else {
                
                guard let data = response.data else {
                    return
                }
                do {
                    let json = try JSON(data: data)
                    complete(json)
                }catch{
                    print("ERROR fetch all message!")
                }
            }
        }
        
        
    }
    
    
    func addNewMessage(channelId: String,message: String,complete: @escaping (Bool) -> Void){
        
        let header = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(AuthService.instance.token)"
        ]
        
        let user = UserDataService.instance
        
        let bodyParams = [
            "userId": "\(user.id)",
            "channelId": "\(channelId)",
            "userName":  "\(user.name)"  ,
            "userAvatar":  "\(user.avatarName)"  ,
            "userAvatarColor": "\(user.avatarColor)",
            "messageBody":  "\(message)"
        ]
        
        Alamofire.request(ADD_MESSAGE, method: .post, parameters: bodyParams, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error != nil {
                complete(false)
            }else {
                complete(true)
            }
        }
    }
    
}



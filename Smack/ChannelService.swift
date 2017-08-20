//
//  ChannelService.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ChannelService {
    
    static var instance = ChannelService()
    func addChannel(name: String, description: String, complete: @escaping (Bool) -> Void ){
        
        let header = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(AuthService.instance.token)"
        ]
        let parameter = [
            "name" : name,
            "description": description
        ]
        Alamofire.request(ADD_CHANNEL_URL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error != nil{
                complete(false)
            }else {
                complete(true)
            }
        }
    }
    func fetchAllChannel(complete: @escaping (Data) -> Void){
        let header = [
            "Authorization": "Bearer \(AuthService.instance.token)"
        ]
        Alamofire.request(FETCH_ALL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error != nil{
                return
            }else {
                guard let data = response.data else {
                    return
                }
                complete(data)
            }
        }
    }
    
}

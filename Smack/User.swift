//
//  User.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/19/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class User {
    static var instance = User()
    
    func findUserByEmail(email: String, completion: @escaping (Bool,[String]?) -> Void  ){
        
        print(AuthService.instance.token)
        let header = [
            "Authorization": "Bearer \(AuthService.instance.token)"
        ]
        
        let url = "\(BASE_URL)/user/byEmail/\(email)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error != nil {
                print(response.result)
                completion(false, nil)
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
                    
                completion(true,[_id,email,name,avatarName,avatarColor])
                }catch{
                    debugPrint("Can't create user data")
                }

            }
        }
        
    }
}

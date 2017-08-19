//
//  UserDataService.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation
class UserDataService {
    
    static var instance = UserDataService()
    
    public private(set) var id: String!
    public private(set) var name: String!
    public private(set) var email: String!
    public private(set) var avatarName: String!
    public private(set) var avatarColor: String!
    
    func setUserData(id: String, email: String, name: String, avatarName: String, avatarColor: String){
        self.id = id
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.name = name
    }

    
}

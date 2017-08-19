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

    func convertColor() -> UIColor{
        let colors = self.avatarColor?.components(separatedBy: ",")
        
        guard colors != nil && colors?.count == 3 else {
            return UIColor.red
        }
        
        guard let red = NumberFormatter().number(from: (colors?[0])!) else{
            return UIColor.red
        }
        guard let green = NumberFormatter().number(from: (colors?[0])!) else{
            return UIColor.red
        }
        guard let blue = NumberFormatter().number(from: (colors?[0])!) else{
            return UIColor.red
        }
        
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        
        return color
    }
    func logout(){
        id = ""
        name = ""
        email = ""
        avatarName = ""
        avatarColor = ""
    }
}

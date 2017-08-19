//
//  ChatVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/17/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        if AuthService.instance.isLoggedIn {
            print(true)
            
            let email = AuthService.instance.loggedInEmail
            print("email \(email)")
            User.instance.findUserByEmail(email: email, completion: { (complete, data) in
                if complete {
                    AuthService.instance.updateUserData(data: data!)
                }
            })
            
            NotificationCenter.default.post(name: NOTI_USERDATA_CHANGE, object: nil)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

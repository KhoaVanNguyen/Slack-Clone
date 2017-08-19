//
//  ChannelVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/17/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
   
    @IBAction func prepareForUnWind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
     
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUserData(_:)), name: NOTI_USERDATA_CHANGE, object: nil)
        
        
       
        
    }
    func updateUserData(_ notfi: Notification){
        let userData = UserDataService.instance
        
        
        
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(userData.name, for: .normal)
            avatarImage.image = UIImage(named: userData.avatarName)
            avatarImage.backgroundColor = UserDataService.instance.convertColor()
        }else {
            loginButton.setTitle("Login", for: .normal)
            avatarImage.image = UIImage(named: "profileDefault")
            avatarImage.backgroundColor = UIColor.green
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let isLoggedIn = AuthService.instance.isLoggedIn
//        if  isLoggedIn {
//            let userData = UserDataService.instance
//            
//            if let img = userData.avatarName {
//                avatarImage.image = UIImage(named: img)
//                
//            }
//            
//            if let name = userData.name {
//                loginButton.setTitle(name, for: .normal)
//            }
//            
//            //  avatarImage.backgroundColor = UIColor.red
//            
//            loginButton.isEnabled = false
//            
//        }
    }

    

    @IBAction func login_touchUpInside(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }

}

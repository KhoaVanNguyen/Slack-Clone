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
            avatarImage.backgroundColor = UIColor.clear
        }
        
        
    }
    

    @IBAction func login_touchUpInside(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        }else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
        
    }

}

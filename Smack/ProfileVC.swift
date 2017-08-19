//
//  ProfileVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/19/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        let user = UserDataService.instance
        self.emailLabel.text = user.email
        self.usernameLabel.text = user.name
        self.profileImage.image = UIImage(named: user.avatarName)
        self.profileImage.backgroundColor = UserDataService.instance.convertColor()
    }
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        AuthService.instance.logout()
        NotificationCenter.default.post(name: NOTI_USERDATA_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func close_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

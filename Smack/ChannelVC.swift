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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
    }

    

    @IBAction func login_touchUpInside(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }

}

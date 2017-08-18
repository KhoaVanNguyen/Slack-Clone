//
//  LoginVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    @IBAction func dismiss_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  LoginVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
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
    
    @IBAction func login_TouchUpInside(_ sender: Any) {
        guard let email = emailTF.text else {
            return
        }
        guard let password = passwordTF.text else {
            return
        }
        
        AuthService.instance.login(email: email, password: password) { (result) in
            
            if result {
                User.instance.findUserByEmail(email: email, completion: { (isComplete, data) in
                    if isComplete {
                        UserDataService.instance.setUserData(id: (data?[0])!, email: (data?[1])!, name: (data?[2])!, avatarName: (data?[3])!, avatarColor: (data?[4])!)
                        
                        NotificationCenter.default.post(name: NOTI_USERDATA_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            } else {
                self.showAlert(title: "ERROR", message: "Can't login, please check your email or password!")
            }
        }
    }
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

}

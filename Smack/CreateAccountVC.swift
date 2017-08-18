//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/18/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import Alamofire

class CreateAccountVC: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
  
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func createAccount_TouchUpInside(_ sender: Any) {
        guard let email = emailTF.text else {
            showAlert(title: "Error", message: "Vui long nhap email")
            return
        }
        
//        guard let username = usernameTF.text else {
//            showAlert(title: "Error", message: "Vui long nhap username")
//            return
//        }
        
        guard let password = passwordTF.text else {
            showAlert(title: "Error", message: "Vui long nhap mat khau")
            return
        }
       
        AuthService.instance.createAccount(email: email, password: password) { (complete) in
            print(complete)
        }
      
        
    }

    
    @IBAction func close_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

}

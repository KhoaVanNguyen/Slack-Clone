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
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var chooseAvatarButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var avatarName = "dark15"
    var avatarColor = "0,1,0.5,1"
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
        
        guard let username = usernameTF.text else {
            showAlert(title: "Error", message: "Vui long nhap username")
            return
        }
        
        guard let password = passwordTF.text else {
            showAlert(title: "Error", message: "Vui long nhap mat khau")
            return
        }
       
        AuthService.instance.createAccount(email: email, password: password) { (complete) in
            AuthService.instance.login(email: email, password: password, completion: { (complete) in
                AuthService.instance.createUserData(email: email, username: username, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (complete) in
                    if complete {
                        
                        NotificationCenter.default.post(name: NOTI_USERDATA_CHANGE, object: nil)
                        print("complete \(complete)")
                        self.performSegue(withIdentifier: UNWIND, sender: nil)
                    }
                })
            })
        }
      
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

    @IBAction func chooseAvatar_TouchUpInside(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CHOOSE_AVATAR, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_CHOOSE_AVATAR{
            if let chooseAvatarVC = segue.destination as? ChooseAvatarVC{
                chooseAvatarVC.delegate = self
            }
        }
    }
    @IBAction func generateColor_TouchUpInside(_ sender: Any) {
        
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        
        
        
        
        let randomColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        
        profileImage.backgroundColor = randomColor
        generateButton.setTitle("THIS COLOR", for: .normal)
        generateButton.setTitleColor(randomColor, for: .normal)
        
       avatarColor = "\(red),\(green),\(blue)"
        
        
        
    }
}

extension CreateAccountVC: ChooseAvatarDelegate{
    func getImage(img: String) {
        print(img)
        profileImage.image = UIImage(named: img)
        chooseAvatarButton.isHighlighted = false
        avatarName = img
    }
}



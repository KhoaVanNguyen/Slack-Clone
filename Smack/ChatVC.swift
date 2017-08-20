//
//  ChatVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/17/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import SwiftyJSON
class ChatVC: UIViewController {

    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [JSON]()
    var channel = "Home"
    var channelId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHeader()
        tableView.dataSource = self
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        if AuthService.instance.isLoggedIn {
            print(true)
            
            let email = AuthService.instance.loggedInEmail
            User.instance.findUserByEmail(email: email, completion: { (complete, data) in
                if complete {
                    AuthService.instance.updateUserData(data: data!)
                }
            })
            NotificationCenter.default.post(name: NOTI_USERDATA_CHANGE, object: nil)
            fetchMessage()
        }
        
    }
    
    func updateHeader(){
        headerLabel.text = channel
    }
    
    func fetchMessageInChannel(){
        updateHeader()
        fetchMessage()
    }
    
    func fetchMessage(){
        Message.instance.fetchMessageInChannel(id: channelId) { (jsons) in
            for (_,json) in jsons.makeIterator(){
                print(json)
                self.messages.append(json)
            }
            self.tableView.reloadData()
        }
    }
}


extension ChatVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        return cell
    }
}


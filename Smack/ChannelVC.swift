//
//  ChannelVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/17/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import SwiftyJSON
class ChannelVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBAction func prepareForUnWind(segue: UIStoryboardSegue){}
    
    var channels = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        
        fetchChannels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification(_:)), name: NOTI_USERDATA_CHANGE, object: nil)
    }
    
    func fetchChannels(){
        self.channels = []
        ChannelService.instance.fetchAllChannel { (data) in
            do {
                let json = try JSON(data: data)
                
                for (_,subJson):(String,JSON) in json {
                    self.channels.append(subJson)
                    
                }
                self.tableView.reloadData()
            }catch {
                print("ERROR in fetch all channels in Channel VC")
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    func handleNotification(_ notfi: Notification){
        updateData()
        
    }
    
    func updateData(){
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
    
    @IBAction func createChannel_TouchUpInside(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let createChannelVC = CreateChannelVC()
            createChannelVC.modalPresentationStyle = .custom
            createChannelVC.delegate = self
            present(createChannelVC, animated: true, completion: nil)
        }else {
            showAlert(title: "ERROR", message: "Please login to create channel!")
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
    
    func showAlert(title: String, message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

}
extension ChannelVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! ChannelCell
        let name = channels[indexPath.row]["name"].stringValue
        cell.configureCell(text: "#\(name)")
        return cell
    }
}

extension ChannelVC: CreateChannelDelegate{
    func updateChannels() {
        print("updating")
        fetchChannels()
    }
}

//
//  CreateChannelVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit


protocol CreateChannelDelegate {
    func updateChannels()
}

class CreateChannelVC: UIViewController {
    @IBOutlet weak var channelNameTF: UITextField!

    @IBOutlet weak var channelDescriptionTF: UITextField!
    
    var delegate: CreateChannelDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func close_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func create_TouchUpInside(_ sender: Any) {
        
        guard let name = channelNameTF.text else {
            return
        }
        guard let description = channelDescriptionTF.text else {
            return
        }
        
        ChannelService.instance.addChannel(name: name, description: description) { (complete) in
            if complete{
                self.delegate?.updateChannels()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

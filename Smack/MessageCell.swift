//
//  MessageCell.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
import SwiftyJSON
class MessageCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    
    
    var message: JSON?{
        didSet{
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(){
        guard let json = message else {
            return
        }
        usernameLabel.text = json["userName"].stringValue
        messageLabel.text = json["messageBody"].stringValue
        profileImage.image = UIImage(named: json["userAvatar"].stringValue)
    }

  

}

//
//  ChannelCell.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/20/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    
    func configureCell(text: String){
        channelLabel.text = text
    }
    
    

  

}

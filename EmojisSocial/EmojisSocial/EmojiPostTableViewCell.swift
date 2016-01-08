//
//  EmojiPostTableViewCell.swift
//  EmojisSocial
//
//  Created by Samuel Shaw on 1/7/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class EmojiPostTableViewCell: UITableViewCell
{
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

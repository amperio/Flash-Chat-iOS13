//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Juan Navarro  on 2/27/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBuggle: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var img_youAvatar: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBuggle.layer.cornerRadius = messageBuggle.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

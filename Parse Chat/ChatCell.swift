//
//  ChatCell.swift
//  Parse Chat
//
//  Created by Samuel Carbone on 1/31/18.
//  Copyright © 2018 Samuel Carbone. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

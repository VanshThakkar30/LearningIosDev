//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Jinfoappz on 22/05/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var rightSideImage: UIImageView!
    @IBOutlet weak var leftSideImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

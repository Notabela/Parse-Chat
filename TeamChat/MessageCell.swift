//
//  MessageCell.swift
//  TeamChat
//
//  Created by daniel on 2/19/17.
//  Copyright © 2017 Notabela. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell
{

    @IBOutlet weak var messageLabel: UILabel!
    
    var message: String?
    {
        didSet
        {
            messageLabel.text = message
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

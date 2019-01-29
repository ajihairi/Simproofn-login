//
//  InboxTableViewCell.swift
//  Simproofn
//
//  Created by Hamzhya on 28/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImageView.setRounded()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    

    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var recievedLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.accessoryType = selected ? .none : .none
    }

}

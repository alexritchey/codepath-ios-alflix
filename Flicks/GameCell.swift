//
//  GameCell.swift
//  Flicks
//
//  Created by Alex Ritchey on 9/14/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

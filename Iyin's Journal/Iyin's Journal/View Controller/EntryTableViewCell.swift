//
//  EntryTableViewCell.swift
//  Iyin's Journal
//
//  Created by Iyin Raphael on 8/16/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodytextLabel: UILabel!
}

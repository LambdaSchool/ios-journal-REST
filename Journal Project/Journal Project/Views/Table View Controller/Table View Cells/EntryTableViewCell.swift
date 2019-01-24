//
//  EntryTableViewCell.swift
//  Journal Project
//
//  Created by Michael Flowers on 1/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

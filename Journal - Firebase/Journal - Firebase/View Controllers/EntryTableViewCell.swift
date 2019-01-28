//
//  EntryTableViewCell.swift
//  Journal - Firebase
//
//  Created by Jaspal on 1/28/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
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
    
    // MARK: Outlets and Actions
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
}

//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Moin Uddin on 9/13/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    func updateViews() {
        entryTitle?.text = entry?.title
        entryBody?.text = entry?.bodyText
        entryTimestamp?.text = DateFormatter().string(from: (entry?.timestamp)!)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var entryBody: UILabel!
    @IBOutlet weak var entryTimestamp: UILabel!
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    

}

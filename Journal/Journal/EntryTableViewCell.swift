//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Jocelyn Stuart on 1/24/19.
//  Copyright © 2019 JS. All rights reserved.
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
    
    
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        
        entryTitleLabel.text = entry.title
        // entryTimestampLabel.text = String(entry.timestamp)
        entryBodyLabel.text = entry.bodyText
    }
    
    
    @IBOutlet weak var entryTitleLabel: UILabel!
    
    
    @IBOutlet weak var entryTimestampLabel: UILabel!
    
    @IBOutlet weak var entryBodyLabel: UILabel!
    
}

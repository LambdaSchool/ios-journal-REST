//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Jocelyn Stuart on 1/24/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    let dateFormatter = DateFormatter()
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let timeText = dateFormatter.string(from: entry.timestamp)
        
        entryTitleLabel.text = entry.title
        entryTimestampLabel.text = timeText
        entryBodyLabel.text = entry.bodyText
    }
    
    
    @IBOutlet weak var entryTitleLabel: UILabel!
    
    
    @IBOutlet weak var entryTimestampLabel: UILabel!
    
    @IBOutlet weak var entryBodyLabel: UILabel!
    
}

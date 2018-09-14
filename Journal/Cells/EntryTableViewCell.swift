//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Jason Modisett on 9/13/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    private func updateViews() {
        guard let entry = entry else { return }
        
        entryTitleLabel.text = entry.title
        entryContentTextLabel.text = entry.bodyText
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let timestampString = formatter.string(from: entry.timestamp)
        
        entryTimestampLabel.text = timestampString
    }

    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryContentTextLabel: UILabel!
    @IBOutlet weak var entryTimestampLabel: UILabel!
    
    var entry: Entry? { didSet { updateViews() }}
    
}

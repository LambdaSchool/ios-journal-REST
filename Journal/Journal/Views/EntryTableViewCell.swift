//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Linh Bouniol on 8/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyTextLabel: UILabel!
    @IBOutlet var timestampLabel: UILabel!
    
    func updateViews() {
        guard let entry = entry else { return }
        
        titleLabel?.text = entry.title
        bodyTextLabel?.text = entry.bodyText
        
        let dateFormatter = DateFormatter()
        // Style of date format you want
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        timestampLabel?.text = dateFormatter.string(from: entry.timestamp)
    }
    
}

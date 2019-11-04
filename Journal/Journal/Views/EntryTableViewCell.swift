//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Lisa Sampson on 8/16/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    func updateViews() {
        guard let entry = entry else { return }
        
        titleLabel.text = entry.title
        bodyTextLabel.text = entry.bodyText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        timestampLabel.text = dateFormatter.string(from: entry.timestamp)
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
}

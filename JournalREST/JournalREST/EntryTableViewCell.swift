//
//  EntryTableViewCell.swift
//  JournalREST
//
//  Created by Daniela Parra on 9/13/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    func updateViews() {
        guard let entry = entry else { return }
        
        //handle timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        let date = dateFormatter.string(from: entry.timestamp)
        
        titleTextLabel.text = entry.title
        bodyTextLabel.text = entry.bodyText
        timestampLabel.text = date
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
}

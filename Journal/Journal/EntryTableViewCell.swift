//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Nathanael Youngren on 1/24/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    func updateViews() {
        guard let entry = entry else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let date = entry.timestamp
        let dateString = dateFormatter.string(from: date)
        
        title.text = entry.title
        time.text = dateString
        bodyText.text = entry.bodyText
    }
    
    // Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    
}

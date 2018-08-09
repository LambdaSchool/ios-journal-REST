//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Jeremy Taylor on 8/9/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import UIKit




class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        
        guard let entry = entry else { return }
        titleLabel.text = entry.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        let dateString = dateFormatter.string(from: entry.timestamp)
        
        timestampLabel.text = dateString
        bodyLabel.text = entry.bodyText
    }
    
}

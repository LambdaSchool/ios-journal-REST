//
//  EntryTableViewCell.swift
//  Journal-REST
//
//  Created by Moses Robinson on 1/24/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    private func updateViews() {
        guard let entry = entry else { return }
        
        titleLabel.text = entry.title
        bodyLabel.text = entry.bodyText
        timestampLabel.text = "\(entry.timestamp)"
    }
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
}

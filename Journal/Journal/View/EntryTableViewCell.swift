//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Dillon McElhinney on 9/13/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    // MARK: - Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    // MARK: - Utility Methods
    private func updateViews() {
        guard let entry = entry else { return }
        
        titleLabel.text = entry.title
        bodyTextLabel.text = entry.bodyText
        timestampLabel.text = entry.formattedTimestamp
    
    }
    
}

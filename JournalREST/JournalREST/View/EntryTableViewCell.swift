//
//  EntryTableViewCell.swift
//  JournalREST
//
//  Created by Ilgar Ilyasov on 9/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet { updateViews() } // If entry property's values changed then update views
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // MARK: - Update view
    
    private func updateViews() {
        guard let entry = entry else { return }
        
        titleLabel.text = entry.title
        bodyLabel.text = entry.bodyText
        
        // Create a DateFormatter and give a style to the time
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        // Convert Date to String
        let time = formatter.string(from: entry.timestmap)
        
        // Assign it to the label
        timeLabel.text = time
    }
    
}

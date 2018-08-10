//
//  EntryTableViewCell.swift
//  ios-journal-REST
//
//  Created by Lambda-School-Loaner-11 on 8/9/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var bodyText: UILabel!
    
    
    func updateViews() {
        
        guard let entry = entry else { return }
        
        self.title.text = entry.title
        self.timestamp.text = entry.timestamp.description
        self.bodyText.text = entry.bodyText
    }
}

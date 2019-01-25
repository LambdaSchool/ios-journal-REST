//
//  EntryTableViewCell.swift
//  Journal Project
//
//  Created by Michael Flowers on 1/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
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
 
    func updateViews(){
        guard let passedInEntry = entry else { return }
        title.text = passedInEntry.title
        bodyText.text = passedInEntry.bodyText
        timestamp.text = passedInEntry.timestamp.description
    }

}

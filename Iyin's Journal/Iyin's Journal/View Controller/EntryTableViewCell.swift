//
//  EntryTableViewCell.swift
//  Iyin's Journal
//
//  Created by Iyin Raphael on 8/16/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

   
    var entry: Entry? {
        didSet{
            updateViews()
        }
    }

    func updateViews(){
        guard let entry = entry else {return}
        
        titleLabel.text = entry.title
        timestampLabel.text = entry.timestamp.description
        bodytextLabel.text = entry.bodytext
        

    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodytextLabel: UILabel!
}

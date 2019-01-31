//
//  EntryTableViewCell.swift
//  w3r Journal
//
//  Created by Michael Flowers on 1/31/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    var entry: Entry?{
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
                
            }
        }
    }
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    

    func updateViews(){
        guard let passedInEntry = entry else { return }
        
        title.text = passedInEntry.title
        timestamp.text = passedInEntry.timestamp.description
        bodyText.text = passedInEntry.bodyText
    }
    
}

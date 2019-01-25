//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Angel Buenrostro on 1/24/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    var entry: Entry? {
        didSet{
            // TODO: May have to use DispatchQueue to main here
            updateViews()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var entryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(){
        guard let entry = entry else { return }
        nameLabel.text = entry.title
        entryLabel.text = entry.bodyText
        let dateFormatter = DateFormatter()
        let time: String = dateFormatter.string(from: entry.timestamp)
        timeLabel.text = time
        print("This is the time: \(time)")
        //TODO: For some reason the date will not convert to a string
    }

}

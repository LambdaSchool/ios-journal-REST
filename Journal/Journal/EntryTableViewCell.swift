//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class EntryTableViewCell: UITableViewCell {

    //MARK: Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var storyLabel: UILabel!
    
    func updateViews() {
        titleLabel.text = entry?.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/yy hh:mm a"
        timestampLabel.text = dateFormatter.string(from: (entry?.timestamp)!)
        //timestampLabel.text = "\(entry?.timestamp)"
        storyLabel.text = entry?.bodyText
    }
}

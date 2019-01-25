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
        timestampLabel. = entry?.timestamp
        storyLabel.text = entry?.bodyText
    }
}

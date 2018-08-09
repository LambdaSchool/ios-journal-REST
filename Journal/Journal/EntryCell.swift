
import Foundation
import UIKit

class EntryCell:UITableViewCell
{
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!

	var entry:JournalEntry! {
		didSet {
			titleLabel.text = entry.title
			contentLabel.text = entry.content
			let df = DateFormatter()
			df.dateFormat = "dd/mm/yy HH:mm"
			dateLabel.text = df.string(from: entry.timestamp)
		}
	}
	
}

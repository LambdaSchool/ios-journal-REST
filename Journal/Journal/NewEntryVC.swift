
import Foundation
import UIKit

class NewEntryVC:UIViewController
{
	weak var entryList:EntryListTVC!

	@IBOutlet weak var navItem: UINavigationItem!
	@IBOutlet weak var titleField: UITextField!
	@IBOutlet weak var contentField: UITextView!

	var entry:JournalEntry?

	override func viewWillAppear(_ animated: Bool) {
		navItem.title = entry?.title ?? "New Entry"
		titleField.text = entry?.title ?? ""
		contentField.text = entry?.content ?? ""
	}
	
	@IBAction func saveEntry(_ sender: Any) {
		guard let title = titleField.text, title != "",
			let content = contentField.text, content != "" else {
				return
		}

		var entry = self.entry ?? JournalEntry(title, content)
		entry.title = title
		entry.content = content
		App.controller.addUpdate(entry)
		App.controller.push(entry) {error in
			if error != nil {
				return
			}

			self.entryList.refetchData()
		}


		navigationController?.popViewController(animated: true)
	}
}

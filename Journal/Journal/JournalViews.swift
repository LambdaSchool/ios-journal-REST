//
//  JournalViews.swift
//  Journal
//
//  Created by William Bundy on 8/9/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

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

class EntryListTVC:UITableViewController
{
	var controller:JournalController!
	override func viewDidLoad() {
		controller = App.controller
		refetchData()
	}

	func refetchData()
	{
		controller.fetch { (error) in
			if error != nil {
				return
			}

			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return controller.entries.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let defaultCell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
		guard let cell = defaultCell as? EntryCell else {return defaultCell}

		cell.entry = controller.entries[indexPath.row]
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? NewEntryVC {
			dest.entryList = self
			if let cell = sender as? EntryCell {
				dest.entry = cell.entry
			}
		}
	}
}

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

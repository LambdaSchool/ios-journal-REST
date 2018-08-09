
import Foundation
import UIKit

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

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// the item gets deleted synchronously from the array
			// so we can just reload the row as soon as we return
			controller.delete(controller.entries[indexPath.row]) {(error) in}
			tableView.deleteRows(at: [indexPath], with: .left)
		}
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

//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

class EntryTableViewController: UITableViewController {
    
    let entryController = EntryController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { (error) in
            if let error = error {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as? EntryTableViewCell else { fatalError("Unable to dequeue entry cell") }

        let entry = entryController.entries[indexPath.row]
        cell.entry = entry

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard let editingStyle == .delete else { return }
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//    }
   

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            guard let destination = segue.destination as? EntryDetailViewController else { return }
            destination.entryController = entryController
        }
        
        if segue.identifier == "cellSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let destination = segue.destination as? EntryDetailViewController else { return }
            
            destination.entryController?.entries[indexPath.row]
            destination.entryController = entryController
        }
     
    }

}

//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Linh Bouniol on 8/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    let entryController = EntryController()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Mock entry to show on the database for testing
//        entryController.createEntry(withTitle: "TEst5", bodyText: "messagebroken") { (error) in
//            if let error = error {
//                NSLog("Error creating entry: \(error)")
//                return
//            }
//            
//            self.tableView.reloadData()
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        entryController.fetchEntries { (error) in
            if let error = error {
                NSLog("Error fetching entries: \(error)")
                return
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryTableViewCell

        let entry = entryController.entries[indexPath.row]
        cell.entry = entry

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entryController.entries[indexPath.row]
            // remove the entry
            entryController.delete(entry: entry) { (error) in
                if let error = error {
                    NSLog("Error fetching entries: \(error)")
                    return
                }
                self.tableView.reloadData() // this will remove the cell
                
//                tableView.deleteRows(at: indexPath, with: .automatic)
                // It could take some times for the deletion to happen on the server end, that deleteRows() could delete the wrong row (b/c in the time, a new entry could be added and took over that index)
            }
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? EntryDetailViewController {
            detailVC.entryController = entryController
            
            if segue.identifier == "ShowEntry" {
                guard let index = tableView.indexPathForSelectedRow?.row else { return }
                let entry = entryController.entries[index]
                detailVC.entry = entry
            }
        }
    }
  
}

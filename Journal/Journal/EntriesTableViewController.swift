//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Nathanael Youngren on 1/24/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { (error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        guard let entryCell = cell as? EntryTableViewCell else { return cell }
        
        entryCell.entry = entryController.entries[indexPath.row]

        return entryCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var entries = entryController.entries
        
            entryController.deleteEntry(entry: entries[indexPath.row]) { (error) in
                if let error = error {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    entries.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add" {
            guard let addVC = segue.destination as? EntryDetailViewController else { return }
            addVC.entryController = entryController
        } else if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? EntryDetailViewController,
            let index = tableView.indexPathForSelectedRow else { return }
            detailVC.entryController = entryController
            detailVC.entry = entryController.entries[index.row]
        }
    }

    // Properties
    
    let entryController = EntryController()

}

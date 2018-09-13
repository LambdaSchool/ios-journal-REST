//
//  EntriesTableViewController.swift
//  JournalREST
//
//  Created by Daniela Parra on 9/13/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    // MARK: - Lifecycle function

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Why don't we do anything with the error here?
        entryController.fetchEntries { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryTableViewCell
        
        cell.entry = entryController.entries[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entryController.entries[indexPath.row]
            
            entryController.deleteEntry(entry: entry) { (_) in
                self.entryController.entries.remove(at: indexPath.row)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
            destinationVC.entryController = entryController
            
        } else if segue.identifier == "ShowSegue" {
            guard let destinationVC = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let entry = entryController.entries[indexPath.row]
            destinationVC.entry = entry
            destinationVC.entryController = entryController
        }
    }

    var entryController = EntryController()

}
